provider "aws" {
  region = "us-east-1"
}

# Retrieve the default VPC
data "aws_vpc" "default" {
  default = true
}

# Create a security group in the default VPC
resource "aws_security_group" "neo_test_group" {
  name        = "neo-test-group"
  description = "Security group for testing purposes"
  vpc_id      = data.aws_vpc.default.id

  # Example ingress rule: allow SSH access (port 22) from anywhere
  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Example egress rule: allow all outbound traffic
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "security_group_id" {
  value = aws_security_group.neo_test_group.id
}


