# main.tf

resource "aws_vpc" "demo" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    Name = "sn-demo"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.demo.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.aws_az

  map_public_ip_on_launch = true
}

resource "aws_security_group" "demo-sg" {
 name        = "demo-sg"
 description = "This firewall allows SSH and HTTP"
 vpc_id      = aws_vpc.demo.id

 ingress {
  description = "SSH"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }

 ingress {
  description = "HTTP"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }

 egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 }

 tags = {
   Name = "demo-sg"
 }
}

resource "aws_internet_gateway" "demo-gw" {
 vpc_id = aws_vpc.demo.id

 tags = {
   Name = "demo-gw"
 }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-gw.id
  }

  tags = {
    Name = "demo-rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_instance" "web" {
  # key_name                  = var.aws_key_pair
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.demo-sg.id]
  associate_public_ip_address = true

  user_data = <<-EOT
    #! /bin/bash
    sudo apt-get update
    sudo apt-get install apache2 --yes
    sudo systemctl start apache2
    sudo systemctl enable apache2
    echo "<h1>Terraform Instance Launched Successfully from ServiceNow Request: ${var.sn_request}</h1>" | sudo tee /var/www/html/index.html
  EOT


  tags = {
    Name = var.name
  }
}
