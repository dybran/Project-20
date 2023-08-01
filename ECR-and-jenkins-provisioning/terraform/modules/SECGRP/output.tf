
output "jenkins-sg" {
  value = aws_security_group.tooling["jenkins-sg"].id
}