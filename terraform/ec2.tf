# Create an AWS key pair from the provided public key
resource "aws_key_pair" "jenkins_key" {
  key_name   = "jenkins-key"
  public_key = var.jenkins_public_key
}

# Create an EC2 instance
resource "aws_instance" "linux_docker" {
  ami           = "ami-08c40ec9ead489470"   # Ensure this AMI is valid in us-east-1
  instance_type = "t2.micro"
  key_name      = aws_key_pair.jenkins_key.key_name

  vpc_security_group_ids = [
    aws_security_group.instance_sg.id
  ]

  # Optionally, include user data if needed
  # user_data = file("user_data.sh")

  tags = {
    Name = "LinuxDockerInstance1"
  }
}
