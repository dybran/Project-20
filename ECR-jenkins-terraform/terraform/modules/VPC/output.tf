output "public_subnet" {
  value       = aws_subnet.tooling_subnet.id
  description = "public subnet"
}


output "vpc_id" {
  value = aws_vpc.tooling-vpc.id
}

