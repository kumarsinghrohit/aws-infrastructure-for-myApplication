variable "name" {
  description = "Service name"
}

variable "region" {
  description = "AWS region for e.g. logs"
}

variable "vpc" {
  type = map(string)
  description = "Map of vpc related settings"
  default = {}
}

variable "vpc_subnets" {
  type = map(any)
  description = "vpc subnet ids"
  default = {}
}
