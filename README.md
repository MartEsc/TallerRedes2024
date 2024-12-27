# TallerRedes2024
Trabajo Practico Final de la cátedra Taller de Redes 2024

## Topología de la Solución

![Topologia TP Final drawio](https://github.com/user-attachments/assets/a7162f3e-6c5c-40ac-bbef-3f54c4d1a045)


## Descripción de la Solución
El trabajo realizado consiste de los siguientes sistemas implementados sobre la infraestructura de AWS:
  - Servicio web en servidores Backend
  - Servidor público que ofrece balanceo de carga para acceder a los servicios web Backend
  - Comunicación VoIP sobre Asterisk
  - Servicio de VPN implementado con Wireguard, el cual es necesario para acceder a las instancias mediante SSH
  - Servicio de proxy Squid, para navegación de los usuarios de la VPN
  - Base de datos MariaDB, para ser utilizada por los servidores Backend

## Alcance de la Solución
La solución cuenta con unos scripts de configuración en bash (Userdata) para la instalación del software usado por cada instancia, y la configuración de la VPN.
La configuración de las iptables se realizó manualmente.

## Herramientas utilizadas
  - Terraform
  - AWS VPC / Networking
  - AWS EC2
  - Bash
  - Wireguard
  - Asterisk
  - Squid
  - MariaDB

No se utilizó un balanceador de carga proporcionado por AWS, ni una base de datos de AWS RDS debido a que el enunciado del trabajo prohibía su uso.
Por la misma razón, se optó por usar Iptables para garantizar seguridad, en lugar de AWS Security Groups
