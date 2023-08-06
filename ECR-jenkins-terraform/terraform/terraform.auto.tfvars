region = "us-east-1"

vpc_cidr = "172.16.0.0/16"

subnet_cidr = "172.16.1.0/24"

zone = "us-east-1a"

enable_dns_support = "true"

enable_dns_hostnames = "true"

# enable_classiclink = "false"

environment = "dev"

ami-jenkins = "ami-085c7f8f582f6fd06"

keypair = "dybran-ec2"

account_no = "939895954199"

tags = {
  Owner-Email     = "onwuasoanyasc@gmail.com"
  Managed-By      = "Terraform"
  Billing-Account = "939895954199"
}
