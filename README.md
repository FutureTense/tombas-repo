# tombas-repo
A collection of scripts and files that I find useful.

## tv_steam.sh
This is a shell script that automatically enables the HDMI Output connected to TV, set TV as primary display, and then launch Steam Big Picture. Once Steam Big Picture has closed, the display settings will be reverted.

## NordLynx2WireGuard.sh
This is a shell script that will use an existing NordVPN NordLynx connection to generate a Wireguard compatible configuration file, allowing you to connect to NordVPN servers using a standard Wireguard client. This has significant performance, stability, and security benefits when compared to OpenVPN configurations for NordVPN.
 - To use this, make sure you are using a Linux machine (or maybe WSL) with the official NordVPN CLI app configured. Run the script and it will output a file     nordlynx.conf

## getcities.sh
Pass in a valid country (like united_states) and it will generate a conf file for every city NordVPN has for that country.  Note, these files can be found in the conffiles volume under the country name.

>$ ./getcities.sh united_states 

## ipcheck.sh
Pass in generated conf files and it will strip out the ip address and lookup its actual location using the website `ipinfo.io`.

>$ ./ipcheck.sh conffiles/united_states/*.conf
 
