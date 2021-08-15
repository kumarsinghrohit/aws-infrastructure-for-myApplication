#
# Network definition
#
module "vpc" {
  source                  = "./modules/vpc"
  name                    = local.name
  cidr                    = var.cidr
  public_subnets          = var.public_subnets
  private_subnets         = var.private_subnets
  availability_zones      = var.availability_zones
}


#
# mariadb Database
#
module "storage_mariadb" {
  source      = "./modules/mariadb"
  name        = local.name
  region      = var.region
  vpc         = local.vpc
  vpc_subnets = local.vpc_subnets
}


#
# wordpress ecs cluster
#
module "wordpress_ecs" {
  source      = "./modules/wordpress"
  name        = local.name
  region      = var.region
  vpc         = local.vpc
  vpc_subnets = local.vpc_subnets
  db_hostname = module.storage_mariadb.hostname
}
