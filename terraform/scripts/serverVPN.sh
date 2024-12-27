#!/bin/bash
sudo yum update -y
sudo yum install nginx -y 
sudo yum install iptables -y
sudo echo "1" > /proc/sys/net/ipv4/ip_forward
sudo touch /etc/nginx/conf.d/balancer.conf
sudo iptables -t nat -A POSTROUTING -o enX0 -j MASQUERADE
sleep 1
sudo cat << EOF > /etc/nginx/conf.d/balancer.conf
upstream backend {
    # Define the backend servers
    server 10.0.0.251:88;
    server 10.0.0.252:88;    

}

server {
    listen 80;
    location / {
        proxy_pass http://backend;
       
    }
}
EOF

sleep 1
sudo systemctl start nginx
sudo dnf install gcc git make -y
sudo git clone https://git.zx2c4.com/wireguard-tools
sudo make -C wireguard-tools/src -j$(nproc)
sudo make -C wireguard-tools/src install
#sudo su
sudo mkdir /etc/wireguard
sudo cd /etc/wireguard
wg genkey > taller_private_key
wg pubkey < taller_private_key > taller_public_key
key_privada=$(<taller_private_key)
sudo touch tr0.conf
sudo cat << EOF > /etc/wireguard/tr0.conf
[Interface]
PrivateKey=$key_privada
Address=10.0.1.11/32
ListenPort=51820
EOF
chmod 600 taller_private_key taller_public_key tr0.conf
systemctl enable --now wg-quick@tr0


