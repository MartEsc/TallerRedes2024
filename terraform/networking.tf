# Subnet publica para acceso (/28)
resource "aws_subnet" "public_subnet_server" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/28"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "Public Server Subnet"
  }
}

# Subnet proxy (/28)
resource "aws_subnet" "public_subnet_proxy" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.16/28"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "Public Proxy Subnet"
  }
}

# Subnet privada Backend (/24)
resource "aws_subnet" "backend_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"
  tags = {
    Name = "Private Backend Subnet"
  }
}

# Subnet privada DB (/28)
resource "aws_subnet" "database_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.32/28"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"
  tags = {
    Name = "Private Database Subnet"
  }
}


# Gateway
resource "aws_internet_gateway" "mainGateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "igw-tpFinal"
  }
}

# Tabla de ruteo Servidor Publico / VPN
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mainGateway.id
  }

  tags = {
    Name = "Tabla Publico / VPN"
  }
}

# Tabla de ruteo Backend Subnet
resource "aws_route_table" "backend_database_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "10.0.1.32/28"
    network_interface_id = aws_network_interface.database_interface.id
  }
  tags = {
    Name = "Tabla Backend / Database"
  }
}


# Asociar tabla de ruteo publica con subnet publica de servidores/VPN
resource "aws_route_table_association" "assocGatewayServer" {
  subnet_id      = aws_subnet.public_subnet_server.id
  route_table_id = aws_route_table.public_route_table.id
}

# Asociar tabla de ruteo publica con subnet publica de proxy
resource "aws_route_table_association" "assocGatewayProxy" {
  subnet_id      = aws_subnet.public_subnet_proxy.id
  route_table_id = aws_route_table.public_route_table.id
}

# Asociar tabla de ruteo backend con subnet privada backend
resource "aws_route_table_association" "assocBackendDatabase" {
  subnet_id      = aws_subnet.backend_subnet.id
  route_table_id = aws_route_table.backend_database_route_table.id
}

# Ruta para darle salida a internet a los servidores de backend mediante proxy
resource "aws_route" "backend_proxy_route" {
  route_table_id         = aws_route_table.backend_database_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_instance.proxy_instance.primary_network_interface_id
}

# Asociar tabla de ruteo backend con subnet privada database
resource "aws_route_table_association" "assocDatabaseRouteTable" {
  subnet_id      = aws_subnet.database_subnet.id
  route_table_id = aws_route_table.backend_database_route_table.id
}