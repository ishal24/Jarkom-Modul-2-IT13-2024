#!/bin/bash
echo nameserver 192.168.122.1 >> /etc/resolv.conf

#apt-get update

# Install BIND9 and mcedit
apt-get install -y bind9 mcedit

# AIRDROP
cat <<EOF >> /etc/bind/named.conf.local
zone "airdrop.it13.com" {  
    type master;  
    file "/etc/bind/airdrop/airdrop.it13.com";
};
EOF

mkdir -p /etc/bind/airdrop

cat <<EOF >> /etc/bind/airdrop/airdrop.it13.com
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     airdrop.it13.com. root.airdrop.it13.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      airdrop.it13.com.
@       IN      A       10.70.2.2	; IP Stalber
@       IN      AAAA    ::1
www	    IN	    CNAME	airdrop.it13.com.
medkit  IN      A       10.70.2.4	; IP Lipovka
www.medkit  IN  CNAME   medkit.airdrop.it13.com
EOF

# REDZONE
cat <<EOF >> /etc/bind/named.conf.local
zone "redzone.it13.com" {  
    type master;  
    file "/etc/bind/redzone/redzone.it13.com";
};
EOF

mkdir -p /etc/bind/redzone

cat <<EOF >> /etc/bind/redzone/redzone.it13.com
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     redzone.it13.com. root.redzone.it13.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      redzone.it13.com.
@       IN      A       10.70.2.3	; IP Severny
@       IN      AAAA    ::1
www	    IN	    CNAME	redzone.it13.com.
siren   IN      A       10.70.2.3       ; IP Severny
www.siren       IN      CNAME   siren.redzone.it13.com.
log.siren       IN      A       10.70.2.3       ; IP Severny
www.log.siren   IN      CNAME   log.siren.redzone.it13.com.
EOF

# LOOT
cat <<EOF >> /etc/bind/named.conf.local
zone "loot.it13.com" {  
    type master;  
    file "/etc/bind/loot/loot.it13.com";
};
EOF

mkdir -p /etc/bind/loot

cat <<EOF >> /etc/bind/loot/loot.it13.com
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     loot.it13.com. root.loot.it13.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      loot.it13.com.
@       IN      A       10.70.2.5	; IP MyIta
@       IN      AAAA    ::1
www	IN	CNAME	loot.it13.com.
EOF

# REVERSE DNS
cat <<EOF >> /etc/bind/named.conf.local
zone "2.70.10.in-addr.arpa" {  
    type master;  
    file "/etc/bind/redzone/2.70.10.in-addr.arpa";
};
EOF

cat <<EOF >> /etc/bind/redzone/2.70.10.in-addr.arpa
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     redzone.it13.com. root.redzone.it13.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      redzone.it13.com.
2.70.10.in-addr.arpa	IN	NS	redzone.it13.com.
3                       IN      PTR     redzone.it13.com.
EOF

# DNS SLAVE 
cat <<EOF >> /etc/bind/named.conf.local
zone "airdrop.it13.com" {
    type master;
    notify yes;
    also-notify { 10.70.1.5; };
    allow-transfer { 10.70.1.5; };
    file "/etc/bind/airdrop/airdrop.it13.com";
};

zone "redzone.it13.com" {
    type master;
    notify yes;
    also-notify { 10.70.1.5; };
    allow-transfer { 10.70.1.5; };
    file "/etc/bind/redzone/redzone.it13.com";
};

zone "loot.it13.com" {
    type master;
    notify yes;
    also-notify { 10.70.1.5; };
    allow-transfer { 10.70.1.5; };
    file "/etc/bind/loot/loot.it13.com";
};
EOF

# DNS FORWARDER
rm /etc/bind/named.conf.options

cat <<EOF >> /etc/bind/named.conf.options
options {
        directory "/var/cache/bind";

        // If there is a firewall between you and nameservers you want
        // to talk to, you may need to fix the firewall to allow multiple
        // ports to talk.  See http://www.kb.cert.org/vuls/id/800113

        // If your ISP provided one or more IP addresses for stable
        // nameservers, you probably want to use them as forwarders.
        // Uncomment the following block, and insert the addresses replacing
        // the all-0's placeholder.

        forwarders {
		    192.168.122.1;
        };

        //========================================================================
        // If BIND logs error messages about the root key being expired,
        // you will need to update your keys.  See https://www.isc.org/bind-keys
        //========================================================================
        //dnssec-validation auto;
	    allow-query{any;};

        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};
EOF

# Output confirmation
echo "DNS setup completed."
