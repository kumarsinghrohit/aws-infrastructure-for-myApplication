#
# task definition
#
/*
  - container configuration
  The Task definition allows you to specify which Docker image to use, which ports to expose,
  how much CPU and memory to allot, how to collect logs, and define environment variables.
*/
resource "aws_ecs_task_definition" "wordpress" {
    family                = "wordpress"
    network_mode          = "awsvpc"
    requires_compatibilities = []

    container_definitions = templatefile("${path.module}/container_definition.json", {
      DOCKER_IMAGE = "794382686957.dkr.ecr.us-west-1.amazonaws.com/myApplicationone/wordpress:065a17d4e489be3fed9da3b7e5fcc74c9d79ae4a",
      AWS_LOG_GROUP = "${var.name}-wordpress",
      AWS_LOG_REGION = var.region,
      EFS_VOLUME     = "wordpress",
      WORDPRESS_DB_HOST = var.db_hostname,
      WORDPRESS_DB_USER = "myApplication",
      WORDPRESS_DB_PASSWORD = "PSJt247V$t7kp<=3",
      WORDPRESS_DB_NAME = "wordpress",
      WORDPRESS_TABLE_PREFIX = "wp_"
    })

    volume {
      name = "wordpress"

      efs_volume_configuration {
        file_system_id = aws_efs_file_system.wordpress.id
        root_directory = "/"
      }
    }

    tags = {
      name = "${var.name}-wordpress"
    }
}



resource "aws_cloudwatch_log_group" "wordpress" {
  name              = "${var.name}-wordpress"
  retention_in_days = "3"

  tags = {
    name = "${var.name}-wordpress"
    Application = "wordpress"
  }
}

#
# service definition
#
/*
  A Service is used to guarantee that you always have some number of Tasks running at all times.
  If a Task's container exits due to error, or the underlying EC2 instance fails and is replaced,
  the ECS Service will replace the failed Task
*/

resource "aws_ecs_service" "wordpress" {
  name            = "wordpress"
	cluster         = aws_ecs_cluster.myApplicationone.id
  task_definition = aws_ecs_task_definition.wordpress.arn
	desired_count   = 1

  network_configuration {
    subnets = var.vpc_subnets["private"]
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.myApplicationone.arn
    container_name   = "wordpress"
    container_port   = 80
  }

  lifecycle {
    create_before_destroy = true
  }
}
