#!/bin/bash
echo nameserver 192.168.122.1 >> /etc/resolv.conf

apt-get install bind9 -y

cat <<EOF >> /etc/bind/named.conf.local
zone "airdrop.it13.com" {
    type slave;
    masters { 10.70.1.2; };
    file "/var/lib/bind/airdrop.it13.com";
};

zone "redzone.it13.com" {
    type slave;
    masters { 10.70.1.2; };
    file "/var/lib/bind/redzone.it13.com";
};

zone "loot.it13.com" {
    type slave;
    masters { 10.70.1.2; };
    file "/var/lib/bind/loot.it13.com";
};
EOF