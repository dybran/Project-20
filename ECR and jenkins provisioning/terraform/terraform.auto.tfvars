region = "us-east-1"

vpc_cidr = "172.16.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

enable_classiclink = "false"

preferred_number_of_public_subnets = 1

environment = "dev"

ami-jenkins = "ami-08e23dd3eabdf7456"

keypair = "dybran-ec2"

account_no = "939895954199"

tags = {
  Owner-Email     = "onwuasoanyasc@gmail.com"
  Managed-By      = "Terraform"
  Billing-Account = "939895954199"
}
