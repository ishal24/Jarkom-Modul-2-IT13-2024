# Lapres Praktikum Jaringan Komputer Modul-2 IT13
- anggota
|Nama           | NRP       |
|---------------|-----------|
|Muhammad Faishal Rizqy | 5027221026    |
|Rafif Dhimaz Ardhana   | 5027221026    |

## 1. Membuat rancangan topologi
**Topologi:**
![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/img/topology.png)

**IP Configuration:**
- Erangel
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 10.70.1.1
	netmask 255.255.255.0

auto eth2
iface eth0 inet static
	address 10.70.2.1
	netmask 255.255.255.0
```
- Pochinki
```
auto eth0
iface eth0 inet static
	address 10.70.1.2
	netmask 255.255.255.0
	gateway 10.70.1.1
```
- GatkaTrenches
```
auto eth0
iface eth0 inet static
	address 10.70.1.3
	netmask 255.255.255.0
	gateway 10.70.1.1
```
- GatkaRadio
```
auto eth0
iface eth0 inet static
	address 10.70.1.4
	netmask 255.255.255.0
	gateway 10.70.1.1
```
- Georgopol
```
auto eth0
iface eth0 inet static
	address 10.70.1.5
	netmask 255.255.255.0
	gateway 10.70.1.1
```
- Stalber
```
auto eth0
iface eth0 inet static
	address 10.70.2.2
	netmask 255.255.255.0
	gateway 10.70.2.1
```
- Severny
```
auto eth0
iface eth0 inet static
	address 10.70.2.3
	netmask 255.255.255.0
	gateway 10.70.2.1
```
- Lipovka
```
auto eth0
iface eth0 inet static
	address 10.70.2.4
	netmask 255.255.255.0
	gateway 10.70.2.1
```
- Mylta
```
auto eth0
iface eth0 inet static
	address 10.70.2.5
	netmask 255.255.255.0
	gateway 10.70.2.1
```

## 2. Membuat domain yang mengarah ke Stalber dengan alamat airdrop.xxxx.com dengan alias www.airdrop.xxxx.com
- pertama, buatlah script di pochinki untuk menyimpan konfigurasi-konfigurasi domain,
```nano setup.sh```

kemudian masukan bagian ini untuk nameserver dan instalasi bind9
```bash
echo nameserver 192.168.122.1 >> /etc/resolv.conf

apt-get install -y bind9
```

- selanjutnya untuk pembuatan domain, masukan juga bagian ini kedalam script
```bash
cat <<EOF >> /etc/bind/named.conf.local
zone "airdrop.it13.com" {  
    type master;  
    file "/etc/bind/airdrop/airdrop.it13.com";
};
EOF

mkdir -p /etc/bind/airdrop
```
```bash
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
```

## 3. Membuat domain yang mengarah ke Severny dengan alamat redzone.xxxx.com dengan alias www.redzone.xxxx.com
- masih pada pochinki, masukan juga bagian berikut kedalam script yang telah dibuat tadi
```bash
cat <<EOF >> /etc/bind/named.conf.local
zone "redzone.it13.com" {  
    type master;  
    file "/etc/bind/redzone/redzone.it13.com";
};
EOF

mkdir -p /etc/bind/redzone
```
```bash
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
EOF
```

## 4. Membuat domain yang mengarah ke Mylta dengan alamat loot.xxxx.com dengan alias www.loot.xxxx.com
- masih pada pochinki, masukan juga bagian berikut kedalam script yang telah dibuat tadi
```bash
cat <<EOF >> /etc/bind/named.conf.local
zone "loot.it13.com" {  
    type master;  
    file "/etc/bind/loot/loot.it13.com";
};
EOF

mkdir -p /etc/bind/loot
```
```bash
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
```

## 5. Pastikan domain-domain tersebut dapat diakses oleh seluruh komputer (client) yang berada di Erangel
- run script yang sudah dibuat tadi
```bash setup.sh```
- ping domain-domain yang telah dibuat dari client lain 
run command berikut sebelum melakukan test
![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/img/test_ping.png)
- ***airdrop***
![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/img/test_ping_airdrop.png)
- ***redzone***
![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/img/test_ping_redzone.png)
- ***loot***
![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/img/test_ping_loot.png)

bisa dilihat bahwa ketiga domain tersebut sudah bisa diakses dari client lain yang berada di Erangel

## 6. Pastikan semua komputer (client) dapat mengakses domain redzone.xxxx.com melalui alamat IP Severny
- buatlah reverse dns untuuk domain redzone
```bash
cat <<EOF >> /etc/bind/named.conf.local
zone "2.70.10.in-addr.arpa" {  
    type master;  
    file "/etc/bind/redzone/2.70.10.in-addr.arpa";
};
EOF
```
```bash
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
2.70.10.in-addr.arpa	IN	    NS	    redzone.it13.com.
3                       IN      PTR     redzone.it13.com.
EOF
```

## 7. Buat DNS Slave di Georgopol untuk semua domain yang sudah dibuat sebelumnya


## 8. 


## 9. 


## 10. 


## 11. 


## 12.


## 13. 


## 14. 


## 15. 


## 16. 


## 17. 


## 18. 


## 19. 


## 20.

