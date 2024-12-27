#!\bin\bash
sudo yum update -y
sudo yum install -y iptables
sudo dnf update -y
sudo dnf install -y mariadb105-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysql_secure_installation <<EOF
n
y
taller
taller
y
y
y
y
EOF

echo "[mysqld]\nbind-address = 0.0.0.0" | sudo tee -a /etc/my.cnf.d/mariadb-server.cnf
echo "[mysqld]\nbind-address = 0.0.0.0" | sudo tee -a /etc/my.cnf

#Configuraciones extras que hay que hacer a mano
#sudo mariadb -u root -p
#taller es la contraseña
#GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' IDENTIFIED BY 'taller';
#FLUSH PRIVILEGES;

#Accedemos con:
#sudo mariadb -u admin -p -h 10.0.1.36
#Contraseña: taller
#status para ver que efectivamente se esta ejecutando en la 10.0.1.36
