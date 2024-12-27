# Instancia Servidor Publico / VPN
resource "aws_instance" "public_server_instance" {
  ami           = var.id_imagen
  instance_type = var.tam_instancia
  subnet_id     = aws_subnet.public_subnet_server.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  associate_public_ip_address = true
  key_name      = "tallerredes2024"
  user_data = file("./scripts/serverVPN.sh")
  tags = {
    Name = "Servidor Publico - VPN"
  }
  source_dest_check = false 
}

# Instancia Proxy
resource "aws_instance" "proxy_instance" {
  ami           = var.id_imagen
  instance_type = var.tam_instancia
  key_name      = "tallerredes2024"
  user_data = file("./scripts/proxy.sh")
  tags = {
    Name = "Proxy"
  }
  network_interface {
    network_interface_id = aws_network_interface.proxy_interface.id
    device_index         = 0
  }  
}



# Instancia Backend 1
resource "aws_instance" "backend_voip_instance" {
  ami           = var.id_imagen_ubuntu
  instance_type = var.tam_instancia
  key_name      = "tallerredes2024"
  user_data = file("./scripts/backendVoIP.sh")
  tags = {
    Name = "Backend 1 - VoIP"
  }
  network_interface {
    network_interface_id = aws_network_interface.backend_voip_interface.id
    device_index         = 0
  }
}

# Instancia Backend 2
resource "aws_instance" "backend_2_instance" {
  ami           = var.id_imagen_ubuntu
  instance_type = var.tam_instancia
  key_name      = "tallerredes2024"
  user_data = file("./scripts/backend2.sh")
  tags = {
    Name = "Backend 2"
  }
  network_interface {
    network_interface_id = aws_network_interface.backend_2_interface.id
    device_index         = 0
  }
}


# Instancia DB
resource "aws_instance" "database_instance" {
  ami           = var.id_imagen
  instance_type = var.tam_instancia
  key_name      = "tallerredes2024"
  user_data = file("./scripts/database.sh")
  tags = {
    Name = "Database"
  }
  network_interface {
    network_interface_id = aws_network_interface.database_interface.id
    device_index         = 0
  }
}

# Interfaz DB
resource "aws_network_interface" "database_interface" {
  subnet_id   = aws_subnet.database_subnet.id
  private_ips = ["10.0.1.36"]
  security_groups = [aws_security_group.public_sg.id]
  tags = {
    Name = "Interfaz de red de servidor de Base de Datos"
  }
}


# Interfaz Backend 1 - VoIP
resource "aws_network_interface" "backend_voip_interface" {
  subnet_id   = aws_subnet.backend_subnet.id
  private_ips = ["10.0.0.251"]
  security_groups = [aws_security_group.public_sg.id]
  tags = {
    Name = "Interfaz de red de servidor Backend - VoIP"
  }
}

# Interfaz Backend 2
resource "aws_network_interface" "backend_2_interface" {
  subnet_id   = aws_subnet.backend_subnet.id
  private_ips = ["10.0.0.252"]
  security_groups = [aws_security_group.public_sg.id]
  tags = {
    Name = "Interfaz de red de servidor Backend 2"
  }
}

# Interfaz Proxy
resource "aws_network_interface" "proxy_interface" {
  subnet_id   = aws_subnet.public_subnet_proxy.id
  private_ips = ["10.0.1.20"]
  security_groups = [aws_security_group.public_sg.id]
  tags = {
    Name = "Interfaz de red de servidor Proxy"
  }
}
