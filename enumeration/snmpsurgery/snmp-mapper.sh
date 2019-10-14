#!/bin/bash

if [ -z "$1" ]; then
	echo "[+] Simple SNMP network mapper"
	echo "[+] Usage: $0 <ip/range>"
	exit 0
fi

if [ ! type nmap &> /dev/null ]; then
	echo "[+] This script require nmap"
	echo "[+] apt-get install nmap"
	echo "[+] Or someting like that"
	exit 0
fi

if [ ! -f community ]; then
	echo -n "Community file doesn't exist, create it (Y/n): "
	read rep
	if [ "$rep" == "y" ] || [ "$rep" == "Y" ]; then
		touch community
		echo "public" >> community
		echo "pricvate" >> community
		echo "manager" >> community
	else
		exit 0
	fi
fi

nmap -p161 -sU --open $1 |grep "Nmap scan" |cut -d" " -f5 > hosts.txt
onesixtyone -c community -i hosts.txt

