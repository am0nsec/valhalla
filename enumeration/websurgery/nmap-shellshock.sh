#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "[*] Simply use nmap http-shellshock.nse script to check for cgi_mod vuln"
  echo "[*] Usage: $0 <IP> <URI>"
  echo "[*] Example: $0 10.11.1.71 /cgi-bin/admin.cgi"
  echo ""
  exit 1
fi

echo "[?] Default web port: 80 (to change if needed)"
echo "[?] Try: $1$2"
nmap -p80 $1 \
  --script=http-shellshock.nse \
  --script-args uri="$2"

