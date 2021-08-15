variable "region" {
  description = "AWS region"
  default     = "eu-central-1"
}


variable "availability_zones" {
  description = "availability zone"
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "cidr" {
  description = "Network CIDR"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "public subnet"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "application subnet"
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}
