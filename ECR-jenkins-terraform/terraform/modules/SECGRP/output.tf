
output "jenkins-sg" {
  value = aws_security_group.jenkins-http-ssh-sg.id
}
