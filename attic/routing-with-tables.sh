#!/bin/bash

#http://archive.linuxvirtualserver.org/html/lvs-users/2009-12/msg00008.html

iptables -A PREROUTING -t mangle ! -s 10.0.1.0/24 -p tcp -i br0 --dport 21 -j MARK --set-mark 2
iptables -A PREROUTING -t mangle -m mark --mark 0x2 -j CONNMARK --save-mark
iptables -A OUTPUT -t mangle -j CONNMARK --restore-mark

ip route flush table 2
ip rule add fwmark 2 lookup 2
ip route add default via 10.0.1.2 table 2
ip route flush cache
