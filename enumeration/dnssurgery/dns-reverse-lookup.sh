#!/bin/bash

if [ -z $1 ]; then
	echo -e "\n[+] DNS reverse lookup script"
	echo -e "[+] Usage	: $0 <domaine name>\n"
	exit 0
fi

nameserv=$(host -t NS $1 |cut -d" " -f4 |sed -n 2p)
addr=$(host $nameserv |cut -d" " -f4 |cut -d"." -f1,2,3)
filter=$(echo $1 |cut -d"." -f1)

echo -e "\n[+] Start DNS reverse lookup ...\n"
for x in $(seq 1 254); do
	(host $addr.$x |grep -v "not found" |grep $filter)
done
echo -e "\n[+] End DNS reverse lookup.\n"
