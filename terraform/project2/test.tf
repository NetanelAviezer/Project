provider "aws" {
  region = "us-east-1"
}

# Retrieve the default VPC
data "aws_vpc" "default" {
  default = true
}

# Variable to supply your Jenkins public key
variable "jenkins_public_key" {
  description = "Public key for the Jenkins key pair"
  type        = string
}

# Create a key pair for Jenkins
resource "aws_key_pair" "jenkins_key" {
  key_name   = "jenkins-key"
  public_key = var.jenkins_public_key
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

output "jenkins_key_name" {
  value = aws_key_pair.jenkins_key.key_name
}
