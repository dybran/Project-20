# create jenkins security group

resource "aws_security_group" "jenkins-http-ssh-sg" {
  name        = "jenkins-sg"
  description = "jenkins Security Group"
  vpc_id      = var.vpc_id
}


resource "aws_security_group_rule" "inbound-jenkins-http" {
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins-http-ssh-sg.id
}

resource "aws_security_group_rule" "inbound-jenkins-ssh" {
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins-http-ssh-sg.id
}
