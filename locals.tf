locals {
  name = "myApplicationone"

  # all elements must have the same type
  vpc = {
    "id"                       = module.vpc.vpc_id
  #  "myApplication_namespace_id"      = aws_service_discovery_private_dns_namespace.myApplication.id
  }

  # all elements must have the same type
  vpc_subnets = {
    "storage"                  = module.vpc.private_subnet_ids
    "private"                  = module.vpc.private_subnet_ids
    "public"                   = module.vpc.public_subnet_ids
  }
}
