terraform {
  backend "s3" {
    bucket = "insfrasrsaweb"
    key    = "networking"
    region = "us-east-1"
  }
}

provider "aws" {
    region = var.region
    shared_credentials_files = ["/.aws/credentials", "/.aws/config"]
}

module "networking" {
  source                          = "git::github.com/lelethu-web/ansible-intergration.git?ref=networking"
  region                          = var.region
  vpc_cidr_block                  = var.vpc_cidr_block
  private_subnet_ips              = var.private_subnet_ips
  public_subnet_ips               = var.public_subnet_ips
  availability_zone                = var.availability_zone 
  instance_type                    = var.instance_type
}

module "instance" {
  depends_on                      = [module.networking]
  source                          = "git::github.com/lelethu-web/ansible-intergration.git?ref=instance"
  region                          = var.region
  vpc_id                          = module.networking.vpc_id
  subnet_id                       = module.networking.subnet_id
  availability_zone               = var.availability_zone 
  instance_type                   = var.instance_type
}