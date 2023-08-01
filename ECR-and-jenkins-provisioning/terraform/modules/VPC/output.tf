output "public_subnets-1" {
  value       = aws_subnet.public[0].id
  description = "public subnet 1"
}

# output "public_subnets-2" {
#   value       = aws_subnet.public[1].id
#   description = "public subnet 2"
# }

output "vpc_id" {
  value = aws_vpc.jenkins-vpc.id
}


output "instance_profile" {
  value = aws_iam_instance_profile.ip.id
}