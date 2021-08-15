# myApplication cluster
resource "aws_ecs_cluster" "myApplication" {
  name = var.name
/*
  setting {
    name = "containerInsights"
    value = "enabled"
  }
  */
}

# auto scaling group
resource "aws_autoscaling_group" "myApplication" {
  name                 = var.name
  vpc_zone_identifier  = var.vpc_subnets["private"]
  launch_configuration = aws_launch_configuration.myApplication.name

  desired_capacity = 1
  min_size         = 1
  max_size         = 2

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
}

#
# launch configuration
# on demand instances for prod, spot instances for dev
#
resource "aws_launch_configuration" "myApplication" {
  name_prefix          = var.name
  instance_type        = var.ec2_instance_type
  image_id             = data.aws_ami.latest-amazon-linux.id
  iam_instance_profile = aws_iam_instance_profile.myApplication_instance.name
  #spot_price           = local.spot_price[var.ec2_instance_type]
  user_data            = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.myApplication.name} > /etc/ecs/ecs.config"

  lifecycle {
    create_before_destroy = true
  }
}
