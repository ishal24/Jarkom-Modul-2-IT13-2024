#!/bin/bash
echo nameserver 192.168.122.1 >> /etc/resolv.conf

cat <<EOF >> /etc/resolv.conf
nameserver 10.70.2.2 # IP Stalber
nameserver 10.70.2.3 # IP Severny
nameserver 10.70.2.5 # IP MyIta
EOF

apt-get install dnsutils -y
