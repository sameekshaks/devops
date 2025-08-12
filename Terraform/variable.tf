provider "aws" {
  region = "us-east-1"
}

# VPC
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/20"
  tags = {
    Name = "myvpc"
  }
}

# Public Subnet
resource "aws_subnet" "public_sub" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}

# Private Subnet
resource "aws_subnet" "private_sub" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "igw"
  }
}

# Route Table
resource "aws_route_table" "myroute_table" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
  tags = {
    Name = "myroute_table"
  }
}

# Route Table Association (for Public Subnet)
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_sub.id
  route_table_id = aws_route_table.myroute_table.id
}

# Security Group
resource "aws_security_group" "my_sg" {
  name        = "terra-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "myinstance" {
  ami                    = "ami-020cba7c55df1f615"
  instance_type          = "t3.micro"
  key_name               = "EKS"
  subnet_id              = aws_subnet.public_sub.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  tags = {
    Name = "terra-instance"
  }
}

