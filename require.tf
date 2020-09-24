# require.tf

terraform {
  required_version = "~> 0.13"
}

provider "aws" {
  version = "~> 3.2"
  region  = var.aws_region
}