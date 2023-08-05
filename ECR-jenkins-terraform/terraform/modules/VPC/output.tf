output "public_subnet" {
  value       = aws_subnet.public[0].id
  description = "public subnet"
}


output "vpc_id" {
  value = aws_vpc.tooling-vpc.id
}
