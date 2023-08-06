# # create jenkins security group


# resource "aws_security_group" "jenkins-http-ssh-sg" {
#   vpc_id      = var.vpc_id
#   name        = "jenkins-sg"
#   description = "sec group for jenkins http access"
#   ingress {
#     from_port   = 8080
#     to_port     = 8080
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = merge(
#     var.tags,
#     {
#       Name = format("%s-jenkins-sg", var.name)
#     },
#   )
# }

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