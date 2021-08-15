#
# Determine latest AMI of Amazon Linux 2
#
data "aws_ami" "latest-amazon-linux" {
  most_recent = true
  owners = ["591542846629"] # amazon

  filter {
      name   = "name"
      values = ["amzn2-ami-ecs-hvm-2.0.*-x86_64-ebs"]
  }
}
