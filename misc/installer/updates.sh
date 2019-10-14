#!/bin/bash

apt-get update && \\ 
apt-get dist-upgrade && \\
apt-get purge && \\
apt-get autoclean

echo -n "[+] Reboot computer (y/n): "
read rep

if [ "$rep" == "y" ] || [ "$rep" == "Y" ]; then
	init 6
else
	exit
fi
