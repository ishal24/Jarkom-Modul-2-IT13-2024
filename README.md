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


## 13. Buat Severny, Stalber, Lipovka sebagai worker dan Mylta sebagai Load Balancer
- **Load Balancer**
buat script setup.sh dan masukan script berikut, kemudian jalankan
```bash
#!/bin/bash
echo nameserver 192.168.122.1 >> /etc/resolv.conf

apt-get update
apt-get install -y nginx mcedit apache2 php lynx
apt-get install libapache2-mod-php7.0 -y

a2enmod proxy
a2enmod proxy_http
a2enmod proxy_balancer
a2enmod lbmethod_byrequests

service apache2 restart

rm /var/www/html/index.html

cat <<EOF >> /etc/apache2/sites-available/load-balancer.conf
<VirtualHost *:80>
    ServerName mylta.example.com

    <Proxy balancer://mycluster>
        BalancerMember http://10.70.2.2  # Severny
        BalancerMember http://10.70.2.3  # Stalber
        BalancerMember http://10.70.2.4  # Lipovka
    </Proxy>
    
    ProxyPreserveHost On
    ProxyPass / balancer://mycluster/
    ProxyPassReverse / balancer://mycluster/

    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

service apache2 restart
```
- **testing**

![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/blob/main/img/lipovka_lb.png)

![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/blob/main/img/stalber_lb.png)


## 14. Ubah web server dan load balancer menjadi nginx
- **laod balancer**
buat script baru untuk nginx load balancer
```bash
service apache2 stop
apt-get update
apt-get install nginx -y
echo "upstream loadbalancer {
  server 10.70.2.2; # Stalber
  server 10.70.2.3; # Severny
  server 10.70.2.4; # Lipovka
}

server {
  listen 80;
  server_name mylta.it13.com www.mylta.it13.com;

  location / {
    proxy_pass http://loadbalancer;
  }
}
" > /etc/nginx/sites-available/load_balancer

ln -s /etc/nginx/sites-available/load_balancer /etc/nginx/sites-enabled/load_balancer

rm /etc/nginx/sites-enabled/default

service nginx restart
```

- **worker**
buat script baru untuk nginx worker
```bash
service apache2 stop

apt-get update
apt-get install nginx -y
apt install php php-fpm php-mysql -y
mkdir /var/www/worker
cp /root/lb/worker/index.php /var/www/worker/index.php

service php7.0-fpm start

echo -e "server {
        listen 80;

        root /var/www/worker;
        index index.php index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
                try_files $uri $uri/ /index.php?$query_string;
        }

        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
        }

        location ~ /\.ht {
                deny all;
        }
}" > /etc/nginx/sites-available/worker

ln -s /etc/nginx/sites-available/worker /etc/nginx/sites-enabled/worker

rm /etc/nginx/sites-enabled/default

service nginx restart
```

- **testing**
![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/blob/main/img/stalber_nginx.png)

![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/blob/main/img/lipovka_nginx.png)

## 16. Buat mylta.xxx.com dengan alias www.mylta.xxx.com
- Buka pochinki, edit file /etc/bind/named.conf.local, tambahkan script ini
```bash
zone "mylta.it13.com" {  
    type master;  
    file "/etc/bind/mylta/mylta.it13.com";
};
```
```bash
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     mylta.it13.com. root.mylta.it13.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      mylta.it13.com.
@       IN      A       10.70.2.5	; IP Mylta
@       IN      AAAA    ::1
www	    IN	    CNAME	mylta.it13.com.
```

- **testing**
![Alt text](https://github.com/ishal24/Jarkom-Modul-2-IT13-2024/blob/main/img/mylta.png)

## 17. Konfigurasi agar mylta.xxx.com hanya dapat diakses melalui port 14000 dan 14400
- **laod balancer**
buat script baru untuk nginx load balancer
```bash
service apache2 stop
apt-get update
apt-get install nginx -y
echo "upstream loadbalancer {
  server 10.70.2.2; # Stalber
  server 10.70.2.3; # Severny
  server 10.70.2.4; # Lipovka
}

server {
  listen 14000;
  listen 14400;
  server_name mylta.it13.com www.mylta.it13.com;

  location / {
    proxy_pass http://loadbalancer;
  }
}
" > /etc/nginx/sites-available/load_balancer

ln -s /etc/nginx/sites-available/load_balancer /etc/nginx/sites-enabled/load_balancer

rm /etc/nginx/sites-enabled/default

service nginx restart
```

- **worker**
```bash
service apache2 stop

apt-get update
apt-get install nginx -y
apt install php php-fpm php-mysql -y
mkdir /var/www/worker
cp /root/lb/worker/index.php /var/www/worker/index.php

service php7.0-fpm start

echo -e "server {
        listen 14000;
        listen 14400;

        root /var/www/worker;
        index index.php index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
                try_files $uri $uri/ /index.php?$query_string;
        }

        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
        }

        location ~ /\.ht {
                deny all;
        }
}" > /etc/nginx/sites-available/worker

ln -s /etc/nginx/sites-available/worker /etc/nginx/sites-enabled/worker

rm /etc/nginx/sites-enabled/default

service nginx restart
```

## 18. Akses IP mylta dialihkan ke www.mylta.xxx.com
pada mylta, buka file /etc/apache2/sites-available/000-default.conf, kemudian edit
```bash
<VirtualHost *:80>
    ServerAdmin webmaster@mylta.it13.com
    DocumentRoot /var/www/html

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    Redirect / http://www.mylta.it13.com/
</VirtualHost>
```

## 20. Worker tersebut harus dapat di akses dengan tamat.xxx.com dengan alias www.tamat.xxx.com
- pada Pochinki, buka /etc/bind/named.conf.local, kemudian tambah script berikut
```bash
zone "tamat.it13.com" {  
    type master;  
    file "/etc/bind/tamat/tamat.it13.com";
};
```
kemudian buka
```bash
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     tamat.it13.com. root.tamat.it13.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      tamat.it13.com.
@       IN      A       10.70.2.3
@       IN      AAAA    ::1
www	    IN	    CNAME	tamat.it13.com.
```

# Terima kasih telah membaca, semoga masuk surga aamiin....🙏