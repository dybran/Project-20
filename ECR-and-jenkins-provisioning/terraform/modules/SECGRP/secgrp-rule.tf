# security group for compute module

resource "aws_security_group_rule" "inbound-port-jenkins" {
  type              = "ingress"
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.tooling["jenkins-sg"].id
}

# security group for webservers, to have access only from the internal load balancer and bastion instance.

resource "aws_security_group_rule" "inbound-jenkins-ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.tooling["jenkins-sg"].id
  security_group_id        = aws_security_group.tooling["jenkins-sg"].id
}



