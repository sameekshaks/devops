terraform {
  backend "s3" {
    bucket = "1terra-bucket1"
    region = "us-east-1"
    key = "terraform.tfstate"
    
  }
}
provider "aws" {
    region = "us-east-1"
  
}

resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/20"
    tags = {
        Name = "myvpc"

    }
  
}
resource "aws_subnet" "public_sub" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/16"
    tags = {
        Name = "public subnet"

    }
}
resource "aws_subnet" "private_sub" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.2.0/16"
    tags = {
        Name = "private subnet"

    }
    map_public_ip_on_launch = false
    availability_zone = "us-east-1"
}
resource "aws_route_table" "myroute_table" {
    vpc_id = aws_vpc.myvpc.id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id =aws_internet_gateway.myigw.id
    }
    tags = {
        Name = "myroute_table"
    }
}

resource "aws_internet_gateway" "myigw" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
        Name = "igw"
    }
  
}
resource "aws_instance" "myinstance" {
    ami = "ami-020cba7c55df1f615"
    instance_type = "t3.micro"
    key_name = "EKS"
    vpc_security_group_ids = [sg-0943c3a930ba852be]
    tags = {
      Name = "terra-instance"
    }
  
}

