# security group for compute module

resource "aws_security_group_rule" "inbound-port-jenkins" {
  type              = "ingress"
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins-sg.id
}

resource "aws_security_group_rule" "ssh-port-jenkins" {
  type              = "ingress"
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins-sg.id
}
