# subnet definitions
resource "aws_subnet" "private1" {
  cidr_block          = var.private_subnets[0]
  availability_zone       = var.availability_zones[0]
  vpc_id            = aws_vpc.main.id
  map_public_ip_on_launch = false
  
  tags = {
    Name = "${var.name}-private1"
  }
}

resource "aws_subnet" "private2" {
  cidr_block = var.private_subnets[1]
  availability_zone       = var.availability_zones[1]
  vpc_id            = aws_vpc.main.id
  map_public_ip_on_launch = false
  
  tags = {
    Name = "${var.name}-private2"
  }
}

# Routing private1 -> public1
resource "aws_route_table" "private1" {
 vpc_id            = aws_vpc.main.id
  
 route {
   cidr_block = "0.0.0.0/0"
   myApplication_gateway_id = aws_myApplication_gateway_public1.id
 }
  
 tags = {
  Name = "${var.name}-private1" 
 }
  
  resource "aws_route_table_association" "private1" {
   subnet_id = aws_subnet.private1.id
   route_table_id = aws_route_table.private1.id
  }
}

# Routing private2 -> public1
resource "aws_route_table" "private2" {
 vpc_id            = aws_vpc.main.id
  
 route {
   cidr_block = "0.0.0.0/0"
   myApplication_gateway_id = aws_myApplication_gateway_public1.id
 }
  
 tags = {
  Name = "${var.name}-private2" 
 }
  
  resource "aws_route_table_association" "private2" {
   subnet_id = aws_subnet.private2.id
   route_table_id = aws_route_table.private2.id
  }
}
