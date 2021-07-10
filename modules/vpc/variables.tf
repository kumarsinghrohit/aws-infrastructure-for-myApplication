variable "name" {
  description = "name"
}

variable "cidr" {
  description = "VPC id"
}

variable "public_subnets" {
  description = "subnets used for myApplication"
}

variable "private_subnets" {
  description = "private subnets without external communication"
}

variable "availability_zones" {
  description = "availability zones"
}

