#!/bin/bash

if [ -z "$1" ]; then
  echo "[*] Simple Nmap SMTP vulnerabilty scan"
  echo "[*] Usage: $0 <ip addr>"
  echo ""
  exit 1
fi

# Basic SMTP port 25
# Test all nmap NSE smtp vulnerabilities on a specific target or range

# /usr/share/nmap/scripts/smtp-vuln-cve2010-4344.nse
nmap -p25 --script=smtp-vuln-cve2010-4344 $1 -oN $1-smtp-cve2010-4344-vuln.txt 

# /usr/share/nmap/scripts/smtp-vuln-cve2011-1720.nse
nmap -p25 --script=smtp-vuln-cve2011-1720 $1 -oN $1-smtp-cve2011-1720-vuln.txt

# /usr/share/nmap/scripts/smtp-vuln-cve2011-1764.nse
nmap -p25 --script=smtp-vuln-cve2011-1764 $1 -oN $1-smtp-cve2011-1764-vuln.txt

echo "[*] Down."
