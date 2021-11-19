#! /bin/bash

# This script expects a fully configured and working NordVPN installation. If you do not yet have this setup, do so before running.
# This script will also only work on Arch based distros. If you use another distro then change pacman commands to your desired package manager.

echo "[INFO] Installing prerequisites. This will attempt to use PACMAN - if you are not using an Arch-based distro, you will need to edit this script."
pacman -S wireguard-tools

echo "[INFO] Script will ensure NordVPN is connected and using NordLynx now."
nordvpn s technology nordlynx
nordvpn c
echo "[INFO] NordVPN connected."

echo "[INFO] Now generating config file."
IP=$(/sbin/ifconfig nordlynx | grep 'inet ' | tr -s ' ' | cut -d" " -f3)
LISTENPORT=$(wg showconf nordlynx | grep 'ListenPort = .*')
PRIVATEKEY=$(wg showconf nordlynx | grep 'PrivateKey = .*')
PUBLICKEY=$(wg showconf nordlynx | grep 'PublicKey = .*')
ENDPOINT=$(wg showconf nordlynx | grep 'Endpoint = .*')

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



