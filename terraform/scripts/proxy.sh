#!/bin/bash
sudo yum update -y
sudo yum install -y iptables
sudo yum install squid -y
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -p
sudo iptables -t nat -A POSTROUTING -o enX0 -j MASQUERADE

sudo touch /etc/squid/lista_deny.txt
sudo tee -a /etc/squid/lista_deny.txt <<EOF
mercadolibre.com.ar
mercadopago.com.ar
EOF

sudo systemctl restart squid
