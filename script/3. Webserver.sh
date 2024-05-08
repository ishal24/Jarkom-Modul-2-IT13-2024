#!/bin/bash
echo nameserver 192.168.122.1 >> /etc/resolv.conf

cat <<EOF >> /etc/resolv.conf
nameserver 10.70.2.1
nameserver 10.70.2.2
nameserver 10.70.2.3
nameserver 10.70.2.5
EOF

apt-get install -y nginx mcedit apache2 php lynx