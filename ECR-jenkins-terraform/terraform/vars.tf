variable REGION {
  default = "us-east-1"
}

variable ZONE1 {
  default = "us-east-1a"
}

variable AMIS {
  type = map(any)
  default = {
    us-east-1 = "ami-03951dc3553ee499f"
    us-east-2 = "ami-06ad5df4b191f59d0"
  }
}

variable USER {
  default = "ec2-user"
}

variable PUB_KEY {
  default = "jenkins-ec2.pub"
}

variable PRIV_KEY {
  default = "jenkins-ec2"
}

variable MYIP {
  default = "192.168.33.107/32"
}