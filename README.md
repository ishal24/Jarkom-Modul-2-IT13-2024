# Lapres Praktikum Jaringan Komputer Modul-2 IT13
- Anggota Kelompok

| Nama                   | NRP          |
| ---------------------- | ------------ |
| Muhammad Faishal Rizqy | `5027221026` |
| Rafif Dhimaz Ardhana   | `5027221066` |

## 1. Membuat rancangan topologi
**Topologi:**
![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/blob/main/img/topology.png)

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
![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/blob/main/img/test_ping.png)
- ***airdrop***
![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/blob/main/img/test_ping_airdrop.png)
- ***redzone***
![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/blob/main/img/test_ping_redzone.png)
- ***loot***
![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/blob/main/img/test_ping_loot.png)

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
- **DNS Master (Pochinki)**
buka file /etc/bind/named.conf.local, dan ubah bagian dibawah ini,
![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/blob/main/img/master.png)
edit script tersebut menjadi seperti ini
```bash
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
```

- **DNS Slave (Georgopol)**
buka /etc/bind/named.conf.local dan tambahkan script berikut
```bash
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
```

- **Test**
ubah nameserver pada client menjadi 10.70.1.2 (Pochinki) dan 10.70.1.5 (Georgopol), kemudian coba ping salah satu domain
![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/blob/main/img/slave.png)


## 8. Buat subdomain medkit.airdrop.xxxx.com yang mengarah ke Lipovka
buka file airdrop.it13.com, kemudian tambahkan script berikun dibawah.
```bash
medkit  IN      A       10.70.2.4	; IP Lipovka
www.medkit  IN  CNAME   medkit.airdrop.it13.com
```

## 9. Buat subdomain siren.redzone.xxxx.com dengan delegasi Georgopol yang mengarah ke Severny
buka file redzone.it13.com, kemudian tambahkan script berikun dibawah.
```bash
siren   IN      A       10.70.2.3       ; IP Severny
www.siren       IN      CNAME   siren.redzone.it13.com.
```

## 10. Buat subdomain log dari subdomain log.siren.redzone.xxxx.com dengan IP ke Severny
buka file redzone.it13.com, kemudian tambahkan script berikun dibawah.
```bash
log.siren       IN      A       10.70.2.3       ; IP Severny
www.log.siren   IN      CNAME   log.siren.redzone.it13.com.
```

## 11. Melakukan forwarding dimana hanya Pochinki yang dapat mengakses jaringan luar secara langsung
- **menambah forwarders pada Pochinki**
buka /etc/bind/named.conf.options, kemudian tambahkan bagian ini
```bash
        forwarders {
		      192.168.122.1;
        };
```
![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/blob/main/img/forward.png)

- **cek ip forwarder**
pertama, ganti nameserver pada client menjadi IP Pochinki (10.70.1.3)
kemudian coba ping google dari client
![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/blob/main/img/forward2.png)


## 12. Melakukan deploy website dari Severny menggunakan apache web server
- **setup website di severny**
jalankan script berikut pada severny
```bash
echo nameserver 192.168.122.1 >> /etc/resolv.conf
apt-get install -y nginx mcedit apache2 php libapache2-mod-php7.0
```
kemudian copy index.php ke /var/www/html/
```bash
cp index.php /var/www/html/
```
jalankan apache2
```bash
service apache2 start
```
cek status apache
![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/blob/main/img/apache.png)

- **akses website dati GatkaTrenches**
install lynx
```bash
apt-get install lynx
```
akses website
```bash
lynx http://10.70.2.3/index.php
```
![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/blob/main/img/apache2.png)


## 13. 


## 14. 


## 15. 


## 16. 


## 17. 


## 18. 


## 19. 


## 20.

