#!/bin/bash
echo "-------------------------------------------"
echo "               SMTP MAPPER"
echo "-------------------------------------------"

if [ -z "$1" ]; then
  echo "[+] Simple SMTP service  network mapper"
  echo "[+] Usage: $0 <network addr>"
  exit 0
fi

if [ ! type nmap &> /dev/null ]; then
  echo "[+] This script need netcat (nc), so first install it"
  echo "[+] apt-get install nmap"
  echo "[+] or something like that."
  exit 0
fi

addr=$(echo $1 |cut -d"." -f1,2,3)
for x in $(seq 1 254); do
  if (nmap -p25 $addr.$x |grep open &> /dev/null); then
    echo -e "[\x1b[32m+\x1b[39m] SMTP port open: \t $addr.$x"
    echo $addr.$x >> hosts.txt
  fi
done
