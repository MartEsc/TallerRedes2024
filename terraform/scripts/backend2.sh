#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install apache2 -y
sudo systemctl start apache2

sudo sed -i 's/^Listen 80$/Listen 88/' /etc/apache2/ports.conf
sudo sed -i 's/It works!/Servidor Backend2/' /var/www/html/index.html

sudo systemctl restart apache2