#!/usr/bin/env ruby

=begin
Basic Network mapper with net/ping
https://rubygems.org/gems/net-ping/versions/1.7.8?locale=fr
Send ICMP ping request
=end

require 'net/ping'
require 'thread'

Signal.trap('INT') { throw :sigint }

def banner
  puts "--"*20
  puts "\tBASIC ICMP NETWORK MAPPER "
  puts "--"*20
end

def helper
  puts "HELPER:"
  puts "Exemple: ./networkMapper 10.100.189.0"
  puts ""
  exit
end

def exiting(start_time, end_time, hosts)
  duration = (end_time - start_time).to_i
  puts "\n[+] Scan stop after: " << duration.to_s << "s"
  puts "[+] Total host up: " << hosts.to_s
  exit
end

banner
start_time = Time.now.to_i
hosts = 0
ADDR = (ARGV[0])[0...-1]

if ARGV.length < 1
  helper
end

# Catch ^C and ^Z
catch (:sigint) do
  puts "[INFO] Scan start at: " << Time.now.to_s
  puts "[INFO] Current network addr: " << ARGV[0]

  (1..254).step(1) do |x|
    addr = ADDR + x.to_s
    @icmp = Net::Ping::ICMP.new(addr)

    if (@icmp.ping)
      puts "[+] " + addr + "   -->   \x1b[32mUP\x1b[37m"
      hosts += 1
    else
      puts "[+] " + addr + "   -->   \x1b[35mDOWN\x1b[37m"
    end
  end

  end_time = Time.now.to_i
  exiting(start_time, end_time, hosts)
end

end_time = Time.now.to_i
exiting(start_time, end_time, hosts)
