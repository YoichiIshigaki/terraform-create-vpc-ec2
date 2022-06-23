provider "aws" {

  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

module "vpc" {
  source       = "./module/vpc"
  cidr_vpc     = "10.255.0.0/16"
  cidr_public  = "10.255.1.0/24"
  cidr_private = "10.255.2.0/24"
  public_az    = "ap-northeast-1a"
  private_az   = "ap-northeast-1c"
}

module "ec2" {
  source           = "./module/ec2"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  public_key_path  = "./.ssh/terraform-aws.pub"
  user_data_path   = "./user_data.sh" 
}
