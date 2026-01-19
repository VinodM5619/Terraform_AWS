provider "aws" {
  region = "us-east-1"
}

# Data source to get the existing VPC
data "aws_vpc" "shared" {
  filter {
    name   = "tag:Name"
    values = ["shared-network-vpc"]
  }
}

# Data source to get the existing subnet
data "aws_subnet" "shared" {
  filter {
    name   = "tag:Name"
    values = ["shared-primary-subnet"]
  }
  vpc_id = data.aws_vpc.shared.id
}

# Data source for the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Fetch the latest Ubuntu 20.04 LTS AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "main" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.shared.id
  count =3
  key_name = "managed instance key pair"
  #private_ip    = "172.31.0.1"

  tags = {
    Name = "ansible-instance-${count.index}"
  }
}