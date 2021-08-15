terraform {
  backend "s3" {
    bucket = "terraform-state-myApplication"
    key    = "myApplication/terraform.tfstate"
    region = "eu-central-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
