# Provider Configuration for AWS
provider "aws" {
  region = "us-east-1"
}

# Resource Configuration for AWS
resource "aws_instance" "myserver" {
  ami                    = "ami-cfe4b2b0"
  instance_type          = "t2.micro"
  key_name               = "EffectiveDevOpsAWS2"
  vpc_security_group_ids = ["sg-045681e9e0d985f5f"]

  tags = {
    Name                 = "helloworld"
  }

  # Provisioner for applying Ansible playbook
  provisioner "remote-exec" {
    connection {
      user               = "ec2-user"
      private_key        = "${file("~/.ssh/EffectiveDevOpsAWS.pem")}"
      host = self.public_ip
    }
    inline = [
      "sudo yum install --enablerepo=epel -y ansible git",
      "ansible-pull -U https://github.com/kevingigiano/edop-terraform/ thirdproject/helloworld.yml -i localhost",
    ]
  }
}

# IP address of newly created EC2 instance
output "myserver" {
  value = "${aws_instance.myserver.public_ip}"
}
