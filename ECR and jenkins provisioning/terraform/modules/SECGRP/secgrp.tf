# creating dynamic ingress security groups
locals {
  security_groups = {
    jenkins-sg = {
      name        = "jenkins-sg"
      description = "jenkins security group"
    }
  }
}

