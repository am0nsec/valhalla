#!/bin/bash


if [ -z $1 ] || [ -z $2 ] || [ ! -f $2 ]; then
	echo -e "\n[+] DNS reverse lookup script"
	echo -e "[+] Usage : $0 <domaine name> <file>\n"
	exit 0
fi

echo -e "\n[+] Start DNS forward lookup resolution ...\n"
for x in $(cat $2); do
  (host $x.$1 |grep "has address" |cut -d" " -f1,4)
done
echo -e "\n[+] End DNS forward lookup.\n"
