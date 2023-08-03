resource "aws_key_pair" "jenkins-key" {
  key_name   = "jenkins-ec2"
  public_key = file(var.PUB_KEY)
}

resource "aws_instance" "jenkins-instance" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE
  key_name               = aws_key_pair.jenkins-key.key_name
  subnet_id              = aws_subnet.tooling-pub.id
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  tags = {
    Name    = "Jenkins-docker"
    Project = "tooling"
  }

  provisioner "local-exec" {
    command = "Start-Sleep -Seconds 300"  # Sleep for 2 minutes (adjust as needed)
    interpreter = ["PowerShell", "-Command"]
  }

  provisioner "file" {
    source      = "install.sh"
    destination = "/tmp/install.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/install.sh",
      "sudo /tmp/install.sh"
    ]
  }

  connection {
    user        = var.USER
    private_key = file(var.PRIV_KEY)
    host        = self.public_ip
  }
}

resource "aws_ecr_repository" "ecr_repo" {
  name = "ecr-repo"  
}

# outputs
output "PublicIP" {
  value = aws_instance.jenkins-instance.public_ip
}


output "ecr_repository_url" {
  value = aws_ecr_repository.ecr_repo.repository_url
}