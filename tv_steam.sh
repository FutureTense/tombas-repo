#!/bin/bash

ARG=$1

#turn on tv output, set it as left and primary display, Change output and mode as required.
xrandr --output 'HDMI-0' --mode '3840x2160' --left-of 'DP-2' --primary

#move all windows right, move by X resolution.
output=$(/usr/bin/wmctrl -lG)
while read -r line; do
    $(echo $line | awk '{print "/usr/bin/wmctrl -i -r " $1 " -e 0," $3+3840 ",-1,-1,-1;" }')
done <<< "$output"

sleep 2

if [ "$ARG" == "wine" ]
then
	echo "running wine version"
	wine /crypt/wine/drive_c/Program\ Files/Steam/Steam.exe -no-cef-sandbox
	sleep 6
	pulseaudio -k
else
	/usr/bin/steam-native -bigpicture -fulldesktopres
	sleep 4
	# Kill PA to fix BPM audio.
	pulseaudio -k
fi

#undo the above when steam closes.

#move all windows left
output=$(/usr/bin/wmctrl -lG)
while read -r line; do
    $(echo $line | awk '{print "/usr/bin/wmctrl -i -r " $1 " -e 0," $3-3840 ",-1,-1,-1;" }')
done <<< "$output"

xrandr --output 'DP-3' --primary --output 'HDMI-0' --off
