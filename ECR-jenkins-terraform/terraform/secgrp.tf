resource "aws_security_group" "jenkins-sg" {
  name        = "tooling-prj-sg"
  description = "sec group for jenkins ssh"
  vpc_id      = aws_vpc.tooling.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MYIP]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.MYIP]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tooling-prj-sg"
  }
}