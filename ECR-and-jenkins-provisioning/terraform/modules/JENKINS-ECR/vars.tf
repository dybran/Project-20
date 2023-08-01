variable "subnets-jenkins" {
    description = "public subnets for jenkins instances"
}
variable "ami-jenkins" {
    type = string
    description = "ami for jenkins"
}

variable "sg-jenkins" {
    description = "security group for compute instances"
}
variable "keypair" {
    type = string
    description = "keypair for instances"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}

