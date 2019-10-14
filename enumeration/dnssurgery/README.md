# dnsbruteforce
### generate-subdomains-lists
You can use this script to generate few list with basic subdomain names.</br>
Lists based on the rbsec/dnscan project.

```sh
$ chmod +x generate-subdomains-lists.sh
$ ./generate-subdomains-lists.sh
```
Output:
```sh
$ ls -la
total 96
drwxr-xr-x 2 root root  4096 Feb 26 00:30 .
drwxr-xr-x 5 root root  4096 Feb 26 00:34 ..
-rwxr-xr-x 1 root root  2897 Feb 26 00:30 generate-subdomains-list.sh
-rwxr-xr-x 1 root root   602 Feb 26 00:30 dns-bruteforce.sh
-rw-r--r-- 1 root root 62861 Feb 26 00:20 subdomains-10000.txt
-rw-r--r-- 1 root root  5794 Feb 26 00:20 subdomains-1000.txt
-rw-r--r-- 1 root root   557 Feb 26 00:20 subdomains-100.txt
-rw-r--r-- 1 root root  2883 Feb 26 00:20 subdomains-500.txt
```
### dns-bruteforce
You need to pass two arguments"</br>
ARG 1: the domain name"</br>
ARG 2: the path of the list"</br>
Example: ./dns-bruteforce.sh megacorpone.com /root/Desktop/list.txt"</br>
Example: ./dns-bruteforce.sh megacorpone.com subdomains-100.txt"</br>

```sh
$ chmod +x dns-bruteforce.sh
$ ./dns-bruteforce megacoprone.com subdomains-100.txt
```



