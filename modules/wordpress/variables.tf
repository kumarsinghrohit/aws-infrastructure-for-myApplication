variable "name" {
  description = "ECS name"
}

variable "region" {
  description = "AWS region"
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  default = "t3.small" // t3.small max 3 network interfaces (ENI), 2GB RAM
  #default = "t3a.large"
  #default = "t3a.micro" // t3a.micro max 2 ENIs
  #default = "t3a.medium" // t3a.medium max 3 ENIs, 4GB RAM
}

variable "vpc" {
  type = map(string)
  description = "Map of vpc related settings"
  default = {}
  /*{
    "id"
    "myApplication_namespace_id"
    }*/
}

variable "vpc_subnets" {
  type = map(any)
  description ="VPC subnet Ids"
  default = {}
  /*{
    "myApplication_cluster"
    "storage"
  }*/
}

variable "db_hostname" {

}

variable "cert_arn" {
  default = "arn:aws:acm:eu-central-1:794382686957:certificate/3dda34de-506d-440d-b1cf-262bf9eb837e"
}
