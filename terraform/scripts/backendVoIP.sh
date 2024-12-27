#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install apache2 -y
sudo systemctl start apache2

sudo sed -i 's/^Listen 80$/Listen 88/' /etc/apache2/ports.conf
sudo sed -i 's/It works!/Servidor BackendVoIP/' /var/www/html/index.html

sudo systemctl restart apache2

#Aqui comienza la instalacion de asterisk
sudo apt install asterisk
#Modificar
#sudo nano /etc/asterisk/sip.conf
#sudo nano /etc/asterisk/extensions.conf

#Para manejar asterisk
#sudo asterisk -rvvvv
#sip reload
#dialplan reload