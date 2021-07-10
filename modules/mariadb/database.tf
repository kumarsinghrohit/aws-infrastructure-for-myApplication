#
# AWS Database service
#
resource "aws_db_instance" "mariadb" {
 identifier                 = var.name
 skip_final_snapshot        = "true"
 allocated_storage          = 20
 storage_type               = "gp2"
 engine                     = "mariadb"
 engine_version             = "10.5.8"
 instance_class             = "db.t3.micro"
 name                       = "wordpress"
 username                   = "myApplication"
 password                   = "PSJT23KHDB$<=3"
 db_subnet_group_name       = aws_db_subnet_group.mariadb.name
 vpc_security_group_ids     = [aws_security_group.mariadb.id]
 backup_window              = "02:00-02:30"
 backup_retention_period    = 5
}

resource "aws_db_subnet_group" "mariadb" {
 name         = var.name
 subnet_ids   = var.vpc_subnets["storage"]
  
 tags = {
  Name        = var.name 
 }
}

#ECS instance security group, controls the input and output connections'
#Only VPC internal access allowed!

resource "aws_security_group" "mariadb" {
  name        = "${var.name}-database"
  description = "myApplication database"
  vpc_id      = var.vpc["id"]
  
  ingress {
   from_port = "3306"
   to_port   = "3306"
   protocol  = "tcp"
   cidr_blocks = ["10.0.0.0/16"]
  }
  
  egress {
   from_port = "0"
   to_port   = "0"
   protocol  = "tcp"
   cidr_blocks = ["10.0.0.0/16"]
  }
  
  tags = {
    Name = "${var.name}-database"
  }
}
