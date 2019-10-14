#!/bin/bash

if [ -z "$1" ]; then
  echo "[*] Simply \'htmlize\' a given web page"
  echo "[*] Usage: $0 <URL>"
  echo "[!] Requirement: html2text"
  echo ""
  exit 1
fi

curl $1 -s -L |html2text -width 150 |uniq
