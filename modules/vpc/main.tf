# VPC definition
resource "aws_vpc" "main" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Name = var.name
  }
}

# Internet gateway
resource "aws_internet_gateway" "main" {
 vpc_id = aws_vpc.main.id
  
 tags = {
  Name = var.name 
 }
}

# Route the public subnet traffic through the internet gateway
resource "aws_route" "internet_access" {
  route_table_id        = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id      = aws_internet_gateway.main.id
}

# Default security group to allow internal ingress
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id
  
  ingress {
   from_port = 0
   to_port = 0
   protocol = -1
   cidr_blocks = ["10.0.0.0/16"]
  }
  
  egress {
   from_port = 0
   to_port = 0
   protocol = -1
   cidr_blocks = ["0.0.0.0/0"]
  }
}
