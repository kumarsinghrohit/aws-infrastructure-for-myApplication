# Provider and access details

provider "aws" {
  //version = "3.8.0"
  # credentials have to be be provided via environment variables
  # AWS_ACCESS_KEY_ID: <access key>
  # AWS_SECRET_ACCESS_KEY: <secret key>
  region = var.region
}
