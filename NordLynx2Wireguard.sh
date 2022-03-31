#! /bin/bash

# This is a shell script that will use an existing NordVPN NordLynx connection to generate a Wireguard compatible configuration file, allowing you to connect to NordVPN servers using a standard Wireguard client.
# This has significant performance, stability, and security benefits when compared to OpenVPN configurations for NordVPN.

# This script expects a fully configured and working NordVPN installation. If you do not yet have this setup, do so before running.
# This script will also only work on Arch based distros. If you use another distro then change pacman commands to your desired package manager.


country=$1
city=$2

echo "[INFO] Script will ensure NordVPN is connected and using NordLynx now."
nordvpn d
nordvpn s technology nordlynx
nordvpn c $country $city
echo "[INFO] NordVPN connected."

echo "[INFO] Now generating config file."
IP=$(/sbin/ifconfig nordlynx | grep 'inet ' | tr -s ' ' | cut -d" " -f3)
LISTENPORT=$(wg showconf nordlynx | grep 'ListenPort = .*')
PRIVATEKEY=$(wg showconf nordlynx | grep 'PrivateKey = .*')
PUBLICKEY=$(wg showconf nordlynx | grep 'PublicKey = .*')
ENDPOINT=$(wg showconf nordlynx | grep 'Endpoint = .*')

rm nordlynx.conf
echo "[INTERFACE]" >> nordlynx.conf
echo "# Generated using Tomba's NordLynx2WireGuard Script" >> nordlynx.conf
echo "Address = ${IP}" >> nordlynx.conf
echo "${PRIVATEKEY}" >> nordlynx.conf
echo "DNS = 103.86.96.100" >> nordlynx.conf
echo -e "[PEER]\n" >> nordlynx.conf
echo "${ENDPOINT}" >> nordlynx.conf
echo "${PUBLICKEY}" >> nordlynx.conf
echo "AllowedIPs = 0.0.0.0/0, ::/0" >> nordlynx.conf
echo "PersistentKeepalive = 25" >> nordlynx.conf

echo "Config generated as nordlynx.conf. Printing below."
cat nordlynx.conf
cp nordlynx.conf $city.conf

#echo "XXX"
#echo $city
#size=${#city} 
#echo $size
