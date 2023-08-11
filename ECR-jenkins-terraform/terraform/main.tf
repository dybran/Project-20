# creating VPC
module "VPC" {
  source                              = "./modules/VPC"
  region                              = var.region
  vpc_cidr                            = var.vpc_cidr
  enable_dns_support                  = var.enable_dns_support
  enable_dns_hostnames                = var.enable_dns_hostnames
  subnet_cidr                         = var.subnet_cidr
  zone                                = var.zone
  iam_instance_profile                = var.iam_instance_profile
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
  sg-jenkins    =   [module.SECGRP.jenkins-sg]
  keypair         = var.keypair
}