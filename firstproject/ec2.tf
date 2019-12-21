provider "aws" {
  region     = "us-east-1"
  shared_credentials_file = "./creds"
}

resource "aws_instance" "myserver" {
  ami =                    "ami-cfe4b2b0"
  instance_type =          "t2.micro"
  key_name =               "EffectiveDevOpsAWS2"
  vpc_security_group_ids = ["sg-045681e9e0d985f5f"]
  
  tags = {
    Name =                 "helloworld"
  }
}
