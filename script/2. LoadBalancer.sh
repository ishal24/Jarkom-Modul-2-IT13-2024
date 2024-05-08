#!/bin/bash
echo nameserver 192.168.122.1 >> /etc/resolv.conf

apt-get install -y nginx mcedit apache2 php lynx

a2enmod proxy proxy_http
service apache2 restart

cat <<EOF >> /etc/apache2/sites-available/load-balancer.conf
<VirtualHost *:80>
    ServerName mylta.example.com

    <Proxy balancer://mycluster>
        BalancerMember http://10.70.2.2  # Severny
        BalancerMember http://10.70.2.3  # Stalber
        BalancerMember http://10.70.2.4  # Lipovka
        # Add more BalancerMember lines as needed for additional workers
    </Proxy>

    ProxyPass / balancer://mycluster/
    ProxyPassReverse / balancer://mycluster/
</VirtualHost>
EOF

a2ensite load-balancer.conf

