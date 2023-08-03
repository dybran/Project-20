resource "aws_key_pair" "jenkins-key" {
  key_name   = "jenkins-ec2"
  public_key = file(var.PUB_KEY)
}

resource "aws_instance" "jenkins-instance" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = aws_key_pair.jenkins-key.key_name
  subnet_id              = aws_subnet.jenkins-pub.id
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  tags = {
    Name    = "tooling"
    Project = "Project-tooling"
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

resource "aws_ebs_volume" "vol-dybran" {
  availability_zone = var.ZONE1
  size              = 3
  tags = {
    Name = "dybran-extra-vol"
  }
}

resource "aws_volume_attachment" "attach-vol-dybran" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.vol-dybran.id
  instance_id = aws_instance.dybran-instance.id
}

output "PublicIP" {
  value = aws_instance.jenkins-instance.public_ip
}
