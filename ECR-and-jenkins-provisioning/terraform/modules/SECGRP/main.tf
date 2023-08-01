# create all security groups dynamically
resource "aws_security_group" "jenkins-sg" {
  vpc_id      = var.vpc_id

 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "jenkins-sg"
    },
  )
}