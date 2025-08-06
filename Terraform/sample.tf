provider "aws" {
    region = "us-east-1"
  
}
resource "aws_instance" "myinstance" {
    ami = "ami-0a7d80731ae1b2435"
    instance_type = "t3.micro"
    key_name = "EKS-Key"
    vpc_security_group_ids = ["sg-0943c3a930ba852be"]
  
}