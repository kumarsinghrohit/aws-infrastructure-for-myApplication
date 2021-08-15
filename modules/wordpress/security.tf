#
# Instance IAM role
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/instance_IAM_role.html
#

# Define the role.
resource "aws_iam_role" "myApplicationone_instance" {
 name               = "${var.name}-myApplicationone-instance"
 assume_role_policy = data.aws_iam_policy_document.myApplicationone_instance.json
}

# Allow EC2 service to assume this role.
data "aws_iam_policy_document" "myApplicationone_instance" {
 statement {
   actions = ["sts:AssumeRole"]

   principals {
     type        = "Service"
     identifiers = ["ec2.amazonaws.com"]
   }
 }
}

# Give this role the permission to do ECS Agent things.
resource "aws_iam_role_policy_attachment" "myApplicationone_instance" {
 role       = aws_iam_role.myApplicationone_instance.name
 policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# To actually have the launch configuration launch instances that use our role, we have to create an instance profile
resource "aws_iam_instance_profile" "myApplicationone_instance" {
  name = "${var.name}-myApplicationone-instance"
  role = aws_iam_role.myApplicationone_instance.name
}


#
# Service IAM role
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service_IAM_role.html
#

# Define the role.
resource "aws_iam_role" "myApplicationone_service" {
    name                = "${var.name}-myApplicationone-service"
    path                = "/"
    assume_role_policy  = data.aws_iam_policy_document.myApplicationone_service.json
}

# Give this role the permission to do ECS service things.
resource "aws_iam_role_policy_attachment" "myApplicationone_service" {
    role       = aws_iam_role.myApplicationone_service.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

# Allow EC2 service to assume this role.
data "aws_iam_policy_document" "myApplicationone_service" {
    statement {
        actions = ["sts:AssumeRole"]
        principals {
            type        = "Service"
            identifiers = ["ecs.amazonaws.com", "ecs-tasks.amazonaws.com"]
        }
    }
}

resource "aws_iam_role_policy_attachment" "myApplicationone_secret" {
    role       = aws_iam_role.myApplicationone_service.name
    policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

resource "aws_iam_role_policy_attachment" "myApplicationone_cloudwatchlogs" {
    role       = aws_iam_role.myApplicationone_service.name
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_role_policy_attachment" "myApplicationone_cloudwatch" {
    role       = aws_iam_role.myApplicationone_service.name
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}
