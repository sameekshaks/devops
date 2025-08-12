
resource "aws_vpc" "myvpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = var.vpcname
        project = var.project_name
    }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.pub_cidr
    tags = {
        Name = "${var.project_name}_public_subnet"
        project = var.project_name
    }
    map_public_ip_on_launch = true
    availability_zone = "us-east-1b"
}
resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.pvt_cidr
    tags = {
        Name = "private_subnet"
        project = var.project_name
    }
    map_public_ip_on_launch = false
    availability_zone = "us-east-1a"
}
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
    tags = {
    Name = "myigw"
    project = var.project_name
  }
}

resource "aws_route_table" "" {
  vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myigw.id
    }
   tags = {
    Name = "myroute_table"
    project = var.project_name
  }
}

data "aws_security_group" "mysg" {
  filter {
    name = "group_name"
    values = [ "mysg "]
  }
}
