#!/bin/bash

if [ -z "$1" ]; then
  echo "[*] Simple nmap NSE SMB vulnerabilities checker"
  echo "[*] Usage : $0 <ip addr>"
  echo ""
  exit 0
fi
# Basic SMB ports: 139, 445
# Test all namp NSE smb vulnerabilities on a specific target or range

# /usr/share/nmap/scripts/smb-vuln-ms06-025.nse
nmap -p139,445 --script=smb-vuln-ms06-025 --script-args=unsafe=1 $1 -oN $1-smb-ms06-025-vuln.txt

# /usr/share/nmap/scripts/smb-vuln-ms07_029.nse
nmap -p139,445 --script=smb-vuln-ms07-029 --script-args=unsafe=1 $1 -oN $1-smb-ms07-029-vuln.txt

# /usr/share/nmap/scripts/smb-vuln-ms08-067.nse
nmap -p139,445 --script=smb-vuln-ms08-067 --script-args=unsafe=1 $1 -oN $1-smb-ms08-067-vuln.txt

# /usr/share/nmap/scripts/smb-vuln-ms10-054.nse
nmap -p139,445 --script=smb-vuln-ms10-054 --script-args=unsafe=1 $1 -oN $1-smb-ms10-054-vuln.txt

# /usr/share/nmap/scripts/smb-vuln-ms10-061.nse
nmap -p139,445 --script=smb-vuln-ms10-061 --script-args=unsafe=1 $1 -oN $1-smb-ms10-061-vuln.txt

echo "[*] Down."
