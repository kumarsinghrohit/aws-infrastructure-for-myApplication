# subnet definitions
resource "aws_subnet" "public1" {
  cidr_block          = var.public_subnets[0]
  availability_zone       = var.availability_zones[0]
  vpc_id            = aws_vpc.main.id
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.name}-public1"
  }
}

resource "aws_subnet" "public2" {
  cidr_block = var.public_subnets[1]
  availability_zone       = var.availability_zones[1]
  vpc_id            = aws_vpc.main.id
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.name}-public2"
  }
}

# MyApplication gateway public1
resource "aws_eip" "public1" {
  vpc = true
  depends_on = [aws_internet_gateway.main]
}


reource "aws_myApplication_gateway" "public1" {
  allocation_id = aws_eip.public1.id
  subnet_id = aws_subnet.public1.id
  depends_on = [aws_internet_gateway.main]
  
  tags = {
    Name = var.name
  }
}
