#
# EFS for storage
#
resource "aws_efs_file_system" "wordpress" {
  creation_token = "wordpress"
  performance_mode = "generalPurpose"

  tags = {
    Name = var.name
  }
}

resource "aws_efs_mount_target" "wordpress" {
  file_system_id  = aws_efs_file_system.wordpress.id
  subnet_id       = var.vpc_subnets["private"][0]
  security_groups = [aws_security_group.wordpress.id]
}

resource "aws_efs_mount_target" "wordpress_1" {
  file_system_id  = aws_efs_file_system.wordpress.id
  subnet_id       = var.vpc_subnets["private"][1]
  security_groups = [aws_security_group.wordpress.id]
}

# security group, controls the input and output connections
resource "aws_security_group" "wordpress" {
  name = "wordpress-storage"
  vpc_id = var.vpc["id"]

  //internal efs access
  ingress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags = {
    Name = "wordpress-storage"
  }
}
