# create instance for jenkins
resource "aws_instance" "Jenkins" {
  ami                         = var.ami-jenkins
  instance_type               = "t2.micro"
  subnet_id                   = var.subnets-jenkins
  vpc_security_group_ids      = var.sg-jenkins
  associate_public_ip_address = true
  key_name                    = var.keypair

  tags = merge(
    var.tags,
    {
      Name = "tooling-Jenkins"
    },
  )
}

resource "aws_ecr_repository" "tooling_ecr" {
  tags = merge(
    var.tags,
    {
      Name = "tooling-ECR"
    },
  )
}