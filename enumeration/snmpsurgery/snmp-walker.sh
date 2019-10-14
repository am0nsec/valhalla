#!/bin/bash

function helper(){
	echo "[+] Simple Windows SNMP service data extraction"
	echo "[+] Usage: $0 <option> <ip addr>"
	echo -e "\n[+] OPTIONS:"
	echo -e "\t-a\t a"
	echo -e "\t-d\t a"
	echo -e "\t-h\t a"
	echo -e "\t-hO\t a"
	echo -e "\t-pT\t a"
	echo -e "\t-pU\t a"
	echo -e "\t-sP\t a"
	echo -e "\t-sE\t a"
	echo -e "\t-sS\t a"
	echo -e "\t-sY\t a"
	echo -e "\t-uP\t a"
	echo -e "\t-uS\t a"
	echo -e "\n[+]EXAMPLES:"
	echo "351"
	echo "12"
	exit 0
}

function all() {
	addr=$1
	system $addr
	up_time $addr
	domain $addr
	host_name $addr
	users $addr
	services $addr
	software $addr
	processes $addr
	tcp $addr
	udp $addr
}

function system() {
	echo -e "\x1b[34m###"
	echo -e "# System info: \x1b[39m"
	snmpwalk -c public -v1 $1 1.3.6.1.2.1.1.1 |cut -d":" -f2,3,4 |cut -d'"' -f2
}

function users() {
	echo -e "\x1b[34m###"
	echo -e "# Users Accounts: \x1b[39m"
	snmpwalk -c public -v1 $1 1.3.6.1.4.1.77.1.2.25 |cut -d" " -f4 |cut -d'"' -f2
}

function software() {
	echo -e "\x1b[34m###"
	echo -e "# Installed software: \x1b[39m"
	snmpwalk -c public -v1 $1 1.3.6.1.2.1.25.6.3.1.2
}

function host_name() {
	echo -e "\x1b[34m###"
	echo -e "# Hostname: \x1b[39m"
	snmpwalk -c public -v1 $1 1.3.6.1.2.1.1.5 |cut -d" " -f4 |cut -d'"' -f2
}

function domain() {
	echo -e "\x1b[34m###"
	echo -e "# Domain: \x1b[39m"
	snmpwalk -c public -v1 $1 1.3.6.1.4.1.77.1.4.1 |cut -d" " -f4 |cut -d'"' -f2
}

function up_time() {
	echo -e "\x1b[34m###"
	echo -e "# Uptime: \x1b[39m"
	snmpwalk -c public -v1 $1 1.3.6.1.2.1.1.3 |cut -d"=" -f2
}

function services() {
	echo -e "\x1b[34m###"
	echo -e "# Services: \x1b[39m"
	snmpwalk -c public -v1 $1 1.3.6.1.4.1.77.1.2.3.1.1 |cut -d" " -f4 |cut -d'"' -f2
}

function tcp() {
	echo -e "\x1b[34m###"
	echo -e "# TCP open ports: \x1b[39m"
	snmpwalk -c public -v1 $1 1.3.6.1.2.1.6.13.1.3.0.0.0.0 |cut -d" " -f4 |cut -d'"' -f2
}

function udp() {
	echo -e "\x1b[34m###"
	echo -e "# UDP open ports: \x1b[39m"
	snmpwalk -c public -v1 $1 1.3.6.1.2.1.7.5.1.2.0.0.0.0 |cut -d" " -f4 |cut -d'"' -f2
}

function processes() {
	echo -e "\x1b[34m###"
	echo -e "# System processes: \x1b[39m"
	snmpwalk -c public -v1 $1 1.3.6.1.2.1.25.4.2.1.2
}

echo "-------------------------------------------"
echo " 	 Windows SNMP data extraction"
echo "-------------------------------------------"

if [ ! type snmpwalk &> /dev/null ]; then
	echo "[+] This script require snmpwalk"
	echo "[+] apt-get install snmpwalk"
	echo "[+] Or someting like that"
	exit 0
fi

if [ -z "$1" ] || [ -z "$2" ]; then
	helper
fi

addr=$2
case "$1" in
	-a  ) all $addr;;
	-d  ) domain $addr;;
	-h  ) helper $addr ;;
	-hO ) host_name $addr ;;
	-pT ) tcp $addr ;;
	-pU ) udp $addr ;;
	-sP ) processes $addr;;
	-sE ) services $addr ;;
	-sS ) software $addr ;;
	-sY ) system $addr ;;
	-uP ) up_time $addr ;;
	-uS ) users $addr ;;
	*   ) helper $addr ;;
esac

