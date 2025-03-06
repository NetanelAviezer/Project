provider "aws" {
  region = "us-east-1"
}

# Retrieve the default VPC (required for the security groups)
data "aws_vpc" "default" {
  default = true
}

# (Other resources will be added in separate files)
