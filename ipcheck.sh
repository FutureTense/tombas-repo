#!/usr/bin/env bash


for file in "$@"; do
   ip=$(cat $file | grep Endpoint | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}')
   city=$(curl -s ipinfo.io/$ip/city)
   region=$(curl -s ipinfo.io/$ip/region)
   country=$(curl -s ipinfo.io/$ip/country)
   echo $file.conf ">>" $city, $region, $country
done
