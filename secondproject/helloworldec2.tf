# provider Configuration for AWS
provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "../creds"
}

# Resource Configuration for AWS
resource "aws_instance" "myserver" {
  ami = "ami-cfe4b2b0"
  instance_type = "t2.micro"
  key_name = "EffectiveDevOpsAWS2"
  vpc_security_group_ids = ["sg-045681e9e0d985f5f"]

  tags = {
    Name = "helloworld"
  }

  # Helloworld Application code
  provisioner "remote-exec" {
    connection {
      user = "ec2-user"
#      private_key = pathexpand("~/.ssh/EffectiveDevOpsAWS.pem")
      private_key = "${file("/home/kgigiano/.ssh/EffectiveDevOpsAWS.pem")}"
      host = self.public_ip 
    }
    inline = [
      "sudo yum install --enablerepo=epel -y nodejs",
      "sudo wget https://raw.githubusercontent.com/kevingigiano/edop-ansible/master/roles/helloworld/files/helloworld.js -O /home/ec2-user/helloworld.js",
      "sudo wget https://raw.githubusercontent.com/kevingigiano/edop-ansible/master/roles/helloworld/files/helloworld.conf -O /etc/init/helloworld.conf",
      "sudo start helloworld",
    ]
  }
}
