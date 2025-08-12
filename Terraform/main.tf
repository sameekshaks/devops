

module "myvpcmoudle" {
  source = "./Terraform/vpc"
  vpc_cidr = var.vpc_cidr
  vpcname = var.vpcname
  project_name = var.project_name
  pub_cidr = var.pub_cidr
  pvt_cidr = var.pvt_cidr

}
module "myinstance" {
  source = "./Terraform/instance"
  ami = var.ami
  instance_type = var.instance_type
  project_name = var.project_name
  key_name = var.key_name
  sg = var.sg

}