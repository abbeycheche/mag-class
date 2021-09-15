provider "aws" {
  region     = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "mag-cheche"
    key    = "dev/tfstate"
    region = "us-east-1"
  }
}


resource "aws_vpc" "hero-vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "hero-vpc"
  }
}

resource "aws_subnet" "hero-subnet-pub" {
  vpc_id            = aws_vpc.hero-vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "hero-subnet-pub"
  }
}

resource "aws_subnet" "hero-subnet-priv" {
  vpc_id            = aws_vpc.hero-vpc.id
  cidr_block        = "172.16.20.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "hero-subnet-priv"
  }
}

resource "aws_network_interface" "foo" {
  subnet_id   = aws_subnet.hero-subnet-pub.id
  private_ips = ["172.16.10.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "hero-server" {
  ami           = "ami-087c17d1fe0178315" # us-east-1
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }
}
