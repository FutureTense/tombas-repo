#!/bin/bash
country=$1
output=$(nordvpn cities $country)
upd="A new version of NordVPN is available! Please update the application."
echo "COUNTRY $country"

cities=$output
#cities=$(printf '%s' "${output//$upd/}")

myarray=(`echo $cities | tr ',' ' '`)

spam=13
c=${#myarray[@]}
c=$((c-$spam))

rm -rf conffiles/"$country"
mkdir conffiles/"$country"

for (( i=$spam+0; i<=($c+spam-1); i++ ));
#for (( i=$spam+0; i<=($spam+1); i++ ));
do
   city="${myarray[$i]}"

   city=$(tr -dc '[[:print:]]' <<< "$city")
   ./NordLynx2Wireguard.sh $country $city
   mv "$city".conf conffiles/"$country"
done

