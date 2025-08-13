variable "region" {
  default = "ap-south-1"
}
variable "project" {
  default = "pluto"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "private_cidr" {
  default = "10.0.0.0/24"
}
variable "public_cidr" {
  default = "10.0.1.0/24"
}
variable "environment" {
  default = "devops"
}
variable "image_id" {
  default = "ami-0de716d6197524dd9"
}
variable "key_pair" {
  default = "id_rsa"
}
variable "instance_type" {
  default = "t2.micro"
}

variable "image_id2" {
  default = "ami-020cba7c55df1f615"
}