# creating VPC
module "VPC" {
  source                              = "./modules/VPC"
  region                              = var.region
  vpc_cidr                            = var.vpc_cidr
  enable_dns_support                  = var.enable_dns_support
  enable_dns_hostnames                = var.enable_dns_hostnames
  enable_classiclink                  = var.enable_classiclink
  preferred_number_of_public_subnets  = var.preferred_number_of_public_subnets
  public_subnets                      = [for i in range(2, 5, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
}


module "SECGRP" {
  source = "./modules/SECGRP"
  vpc_id = module.VPC.vpc_id
}




# The Module creates instance for jenkins
module "JENKINS-ECR" {
  source          = "./modules/JENKINS-ECR"
  ami-jenkins     = var.ami-jenkins
  subnets-jenkins = module.VPC.public_subnet
  sg-jenkins    =   module.SECGRP.jenkins-sg
  keypair         = var.keypair
}