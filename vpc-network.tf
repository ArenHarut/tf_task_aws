# Create a VPC
resource "aws_vpc" "webservice" {
  cidr_block         = var.vpc_cidr_block
  enable_dns_support = true
  tags = {
    Name = "DemoForKirills"
  }
}

resource "aws_subnet" "webservice" {
  vpc_id                  = aws_vpc.webservice.id
  cidr_block              = var.webservice_subnet_cidr_block
  availability_zone       = var.webservice_subnet_az
  map_public_ip_on_launch = true

  tags = {
    Name = "Webserver_subnet"
  }
}

resource "aws_subnet" "db" {
  vpc_id                  = aws_vpc.webservice.id
  cidr_block              = var.db_subnet_cidr_block
  availability_zone       = var.db_subnet_az
  map_public_ip_on_launch = true

  tags = {
    Name = "DB_subnet"
  }
}

resource "aws_network_interface" "webservice" {
  subnet_id       = aws_subnet.webservice.id
  private_ips     = ["${var.webservice_nic}"]
  security_groups = [aws_security_group.webserver_sg.id]

  tags = {
    Name = "Webserver_network_interface"
  }
}

resource "aws_network_interface" "db" {
  subnet_id       = aws_subnet.db.id
  private_ips     = ["${var.db_nic}"]
  security_groups = [aws_security_group.db_sg.id]

  tags = {
    Name = "Webserver_network_interface"
  }
}

resource "aws_security_group" "webserver_sg" {
  name        = var.webservice_sg_name
  description = var.webservice_sg_description
  vpc_id      = aws_vpc.webservice.id

  dynamic "ingress" {
  for_each = local.web_inbound_ports
  content {
   from_port = ingress.value
   to_port = ingress.value
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }
 }
  dynamic "egress" {
  for_each = local.outbound_ports
  content {
   from_port = egress.value
   to_port = egress.value
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }
 }
}

resource "aws_security_group" "db_sg" {
  name        = var.db_sg_name
  description = var.db_sg_description
  vpc_id      = aws_vpc.webservice.id

  dynamic "ingress" {
  for_each = local.db_inbound_ports
  content {
   from_port = ingress.value
   to_port = ingress.value
   protocol = "-1"
   cidr_blocks = ["${var.vpc_cidr_block}"]
  }
 }
  dynamic "egress" {
  for_each = local.outbound_ports
  content {
   from_port = egress.value
   to_port = egress.value
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }
 }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.webservice.id

  tags = {
    Name = "DemoForKirills"
  }
}

resource "aws_route_table" "webserver_rt" {
  vpc_id = aws_vpc.webservice.id

  route {
    cidr_block = var.webservice_rt_cidr_block
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "DemoForKirills"
  }
}

resource "aws_route_table_association" "toydeploy-rta" {
  subnet_id      = aws_subnet.webservice.id
  route_table_id = aws_route_table.webserver_rt.id
}

resource "aws_route_table" "db_rt" {
  vpc_id = aws_vpc.webservice.id

  route {
    cidr_block = var.db_rt_cidr_block
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "DemoForKirills"
  }
}

resource "aws_route_table_association" "db-rta" {
  subnet_id      = aws_subnet.db.id
  route_table_id = aws_route_table.db_rt.id
}