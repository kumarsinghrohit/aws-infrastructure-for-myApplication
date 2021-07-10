output "vpc_id" {
 value = aws_vpc.main.id
}

output "public_subnet_ids" {
 value = [aws_subnet.public1.id, aws_subnet.public2.id]
}

output "private_subnet_ids" {
 value = [aws_subnet.private1.id, aws_subnet.private2.id]
}

output "cidr_block" {
 value = aws_vpc.main.cidr_block
}
