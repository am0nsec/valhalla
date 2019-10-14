#!/bin/bash

if [ -z $1 ]; then
  echo -e "\n[+] DNS zone transfer script"
  echo -e "[+] Usage : $0 <domain name>\n"
  exit 0
fi

echo -e "\n[+] Start zone transfer ...\n"
for server in $(host -t NS $1 |cut -d" " -f4); do
  host -a -l $1 $server |grep "has address" |cut -d" " -f1,4
done

echo -e "\n[+] End zone transfer.\n"
