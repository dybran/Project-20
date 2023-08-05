# create jenkins security group
resource "aws_security_group" "jenkins-http-ssh-sg" {
  vpc_id      = var.vpc_id
  name        = "jenkins-sg"
  description = "sec group for jenkins http access"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-sg"
  }
}

