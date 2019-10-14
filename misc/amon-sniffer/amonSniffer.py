#!/usr/bin/python
# coding: utf-8
import socket
import os
import sys
import struct
import binascii
import time

__author__ = "\x1b[31m_amonsec\x1b[37m"
__version__ = "\x1b[33m1.0\x1b[37m"
__language__ = "Python 2.7"
__github__ = "https://www.github.com/amonsec/amonsec-scripts/"
__thanks__ = "http://forum.top-hat-sec.com"

__banner__ = '''
                                   _
     _                            | |   ____        _  __  __
    / \   _ __ ___   ___  _ __    | |  / ___| _ __ (_)/ _|/ _| ___ _ __
   / _ \ | '_ ` _ \ / _ \| '_ \   | |  \___ \| '_ \| | |_| |_ / _ \ '__|
  / ___ \| | | | | | (_) | | | |  | |   ___) | | | | |  _|  _|  __/ |
 /_/   \_\_| |_| |_|\___/|_| |_|  |_|  |____/|_| |_|_|_| |_|  \___|_|

                       \"Sniff packets not drugs\"\n
[+]  Author       |>  %s
[+]  Version      |>  %s
[+]  Language     |>  %s
[+]  Github       |>  %s

[+]  Thanks       |>  %s\n
''' % (__author__, __version__, __language__,  __github__, __thanks__)


def ethernet_layer_analyze(sniffed):
    # More information at:
    # https://en.wikipedia.org/wiki/Ethernet_frame#Structure
    # 6 bytes + 6 bytes + 4 bytes = 14 bytes
    # 6 car / 6 char / unsigned short
    try:
        data = struct.unpack('!6s6sH', sniffed[:14])
        mac_destination = binascii.hexlify(data[0])
        mac_source = binascii.hexlify(data[1])
        mac_protocol = data[2]

        sniffed = sniffed[14:]
        returned = "%s:%s:%s:%s:%s:%s " \
                   % (mac_destination[0:2], mac_destination[2:4], mac_destination[4:6],
                      mac_destination[6:8], mac_destination[8:10], mac_destination[10:12])
        returned += "%s:%s:%s:%s:%s:%s " \
                    % (mac_source[0:2], mac_source[2:4], mac_source[4:6],
                       mac_source[6:8], mac_source[8:10], mac_source[10:12])
        returned += "%s " % mac_protocol
        if hex(mac_protocol) == "0x800":
            ip = "1"
        else:
            ip = "0"

        return sniffed, ip, returned

    except struct.error as error_msg:
        print("Program dump Error:\n %s" % error_msg)
        exit_message()
    except KeyboardInterrupt:
        exit_message()


def network_layer_analyze(sniffed):
    # More information at:
    # https://tools.ietf.org/html/rfc791#section-3.1
    # "Bitwise" operators :
    # https://wiki.python.org/moin/BitManipulation
    # 5 * 4 bytes = 20 bytes
    try:
        network_header = struct.unpack('!6H4s4s', sniffed[:20])
        network_version = network_header[0] >> 12
        network_ihl = (network_header[0] >> 8) & 0x0f
        network_type_of_service = network_header[0] & 0x00ff
        network_total_length = network_header[1]

        network_identification = network_header[2]
        network_flags = network_header[3] >> 13
        network_offset = network_header[3] & 0x1fff

        network_time_to_live = network_header[4] >> 8
        network_protocol = network_header[4] & 0x00ff
        network_header_checksum = network_header[5]

        network_source_address = socket.inet_ntoa(network_header[6])
        network_destination_address = socket.inet_ntoa(network_header[7])

        sniffed = sniffed[20:]
        returned = "%s    %s" % (network_source_address, network_destination_address)
        # 6  -> TCP
        # 17 -> UDP
        if network_protocol == 6:
            whois_next = "TCP"
            return sniffed, whois_next, (returned + "\t %s\t%s" % (whois_next, network_total_length))
        elif network_protocol == 17:
            whois_next = "UDP"
            return sniffed, whois_next, (returned + "\t %s\t%s" % (whois_next, network_total_length))

    except struct.error as error_msg:
        print("Program dump Error:\n %s" % error_msg)
        exit_message()
    except KeyboardInterrupt:
        exit_message()


def tcp_analyze(sniffed):
    # More information at:
    # https://tools.ietf.org/html/rfc793#section-3.1
    # "Bitwise" operators :
    # https://wiki.python.org/moin/BitManipulation
    # 5 * 4 bytes = 20 bytes
    try:
        tcp_header = struct.unpack('!2H2I4H', sniffed[:20])
        tcp_source_port = tcp_header[0]
        tcp_destination_port = tcp_header[1]

        tcp_sequence_number = tcp_header[2]
        tcp_acknowledgment_number = tcp_header[3]

        tcp_offset = tcp_header[4] >> 12
        tcp_reserved = (tcp_header[4] >> 6) & 0x03ff
        tcp_flags = tcp_header[4] & 0x003f
        urg = bool(tcp_flags & 0x0020)
        ack = bool(tcp_flags & 0x0010)
        psh = bool(tcp_flags & 0x0008)
        rst = bool(tcp_flags & 0x0004)
        syn = bool(tcp_flags & 0x0002)
        fin = bool(tcp_flags & 0x0001)
        tcp_window = tcp_header[5]

        tcp_checksum = tcp_header[6]
        tcp_urgentPointer = tcp_header[7]

        flags_to_display = ""
        if urg:
            flags_to_display += " URG "
        if ack:
            flags_to_display += " ACK "
        if psh:
            flags_to_display += " PSH "
        if rst:
            flags_to_display += " RST "
        if syn:
            flags_to_display += " SYN "
        if fin:
            flags_to_display += " FIN "

        returned = "\t%s->%s [%s] Seq=%s  Ack=%s  Win=%s " \
                   % (tcp_source_port, tcp_destination_port, flags_to_display, tcp_sequence_number,
                      tcp_acknowledgment_number, tcp_window)

        return returned

    except struct.error as error_msg:
        print("Program dump Error:\n %s" % error_msg)
        exit_message()
    except KeyboardInterrupt:
        exit_message()


def udp_analyze(sniffed):
    # More information at:
    # https://tools.ietf.org/html/rfc768
    # "Bitwise" operators :
    # https://wiki.python.org/moin/BitManipulation
    # 2 * 4 bytes = 8 bytes
    try:
        udp_header = struct.unpack('!4H', sniffed[:8])
        udp_source_port = udp_header[0]
        udp_destination_port = udp_header[1]

        udp_length = udp_header[2]
        udp_checksum = udp_header[3]

        returned = "\t%s->%s  Len=%s  Checksum=%s" \
                   % (udp_source_port, udp_destination_port, udp_length, udp_checksum)

        return returned

    except struct.error as error_msg:
        print("Program dump Error:\n %s" % error_msg)
        exit_message()
    except KeyboardInterrupt:
        exit_message()


def report(header_1, header_2, count):
    # Finally return the report (╯°□°)╯︵ ┻━┻
    try:
        final = str(header_1) + str(header_2)
        print("[\x1B[31m%d\x1B[37m] %s" % (count, final))
        return

    except KeyboardInterrupt:
        exit_message()


def exit_message():
    print("\n\nScan stop at: %s" % time.strftime("%m-%d-%Y %H:%M:%S"))
    print("Bye 1337.\n")


def main():
    try:
        os.system('clear')
        print(__banner__)
        print("Scan start at: %s\n" % time.strftime("%m-%d-%Y %H:%M:%S"))
        count = 0
        while True:
            time.sleep(0.01)
            s = socket.socket(
                socket.AF_INET,
                socket.SOCK_RAW,
                socket.htons(0x0003)
            )

            sniffed = s.recv(2048)
            count = count+1

            ethernet_response = ethernet_layer_analyze(sniffed)
            ethernet_header = ethernet_response[2]

            if ethernet_response[1] == "1":
                network_response, whoisnext, network_header = network_layer_analyze(ethernet_response[0])

                if whoisnext == "TCP":
                    network_header_tcp = tcp_analyze(network_response)
                    report(network_header, network_header_tcp, count)

                elif whoisnext == "UDP":
                    network_header_udp = udp_analyze(network_response)
                    report(network_header, network_header_udp, count)

            elif ethernet_response[1] == "0":
                report(ethernet_header, "", count)

    except KeyboardInterrupt:
        exit_message()


if __name__ == '__main__':
    sys.exit(main())

