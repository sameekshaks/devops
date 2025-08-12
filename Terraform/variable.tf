variable "vpc_cidr" {
    default = "10.0.0.0/20"
}
variable "vpcname" {
  default = "myvpc"
}
variable "project_name" {
  default = "pulto"
}
variable "pub_cidr" {
  default = "10.0.1.0/24"
}
variable "pvt_cidr" {
  default = "10.0.2.0/24"
}

variable "ami" {
  default = "ami-0f88e80871fd81e91"
}
variable "instance_type" {
    default = "t2.micro"
}
variable "key_name" {
  default = "id_rsa"
}
variable "sg" {
  default = ["sg-0d34c3d2b6fa6492a"]
}

variable "region" {
  default = "us-east-1"
}