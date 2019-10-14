#!/bin/bash

echo "[+] Start program"
if [ "$1" == "" ]; then
  echo "[INFO] You need to give one argument"
  echo -e "[INFO] Exemple: www.cisco.com\n"
  exit
else
  wget $1  
  grep "href=" index.html |cut -d "/" -f 3 |grep "\." |cut -d '"' -f 1 |sort -u > list.txt
  for url in $(cat list.txt); do
    ip=$(host $url |grep "has address" |cut -d " " -f 4 |sort -u)
    echo -e "$url\t\t-->\t$ip"
  done
fi

rm index.html
rm list.txt
