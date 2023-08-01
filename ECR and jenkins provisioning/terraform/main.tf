# creating VPC
module "VPC" {
  source                              = "./modules/VPC"
  region                              = var.region
  vpc_cidr                            = var.vpc_cidr
  enable_dns_support                  = var.enable_dns_support
  enable_dns_hostnames                = var.enable_dns_hostnames
  enable_classiclink                  = var.enable_classiclink
  preferred_number_of_public_subnets  = var.preferred_number_of_public_subnets
  preferred_number_of_private_subnets = var.preferred_number_of_private_subnets
  private_subnets                     = [for i in range(1, 8, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
  public_subnets                      = [for i in range(2, 5, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
}


module "SECGRP" {
  source = "./modules/SECGRP"
  vpc_id = module.VPC.vpc_id
}




# The Module creates instances for jenkins, sonarqube and jfrog
module "JENKINS-ECR" {
  source          = "./modules/JENKINS-ECR"
  ami-jenkins     = var.ami-jenkins
  subnets-jenkins = module.VPC.public_subnets-1
  sg-jenkins      = [module.SECGRP.jenkins-sg]
  keypair         = var.keypair
}