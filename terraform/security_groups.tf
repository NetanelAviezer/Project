resource "aws_security_group" "instance_sg" {
  name        = "linux-docker-sg"
  description = "Allow SSH access to EC2"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Allow SSH access from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow access to RDS from EC2"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description     = "Allow PostgreSQL access from EC2"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.instance_sg.id]  # Restrict to EC2 SG
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
