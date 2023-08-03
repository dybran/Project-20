resource "aws_vpc" "tooling" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "tooling-VPC"
  }
}

resource "aws_subnet" "jenkins-pub" {
  vpc_id                  = aws_vpc.jenkins.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "jenkins-pub"
  }
}

