# AWS용 프로바이더 구성
provider "aws" {
  profile = "default"
  region = "ap-northeast-2"
}

# AWS용 리소스 구성
resource "aws_instance" "dyheo-ansible-terraform" {
  ami = "ami-0e4a9ad2eb120e054"
  associate_public_ip_address = true
  instance_type = "t2.micro"
  availability_zone = "ap-northeast-2a"
  key_name = "dyheo-histech-2"
  vpc_security_group_ids = ["sg-08210a767e39439ac"]
  subnet_id = "subnet-0b92fd86f003a4680"
  tags = {
    Name = "dyheo-terraform-ansible"
  }

# HelloWorld App Code
  provisioner "remote-exec" {
    connection {
      host = self.public_ip
      user = "ec2-user"
      private_key = "${file("~/.ssh/dyheo-histech-2.pem")}"
    }
    inline = [
      "sudo yum install update",
      "sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y",
      "sudo yum install git"
    ]
  }
}
