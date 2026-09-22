terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "networking" {
  source                   = "./modules/networking"
  project_name             = var.project_name
  vpc_cidr                 = var.vpc_cidr
  public_subnet_cidr       = var.public_subnet_cidr
  private_db_subnet_a_cidr = var.private_db_subnet_a_cidr
  private_db_subnet_b_cidr = var.private_db_subnet_b_cidr
  availability_zones       = var.availability_zones
}

module "security" {
  source           = "./modules/security"
  project_name     = var.project_name
  vpc_id           = module.networking.vpc_id
  ssh_ingress_cidr = var.ssh_ingress_cidr
}

module "compute" {
  source                = "./modules/compute"
  project_name          = var.project_name
  public_subnet_id      = module.networking.public_subnet_id
  ec2_security_group_id = module.security.ec2_security_group_id
  instance_type         = var.instance_type
  key_pair_name         = var.key_pair_name
}

module "database" {
  source                 = "./modules/database"
  project_name           = var.project_name
  private_db_subnet_a_id = module.networking.private_db_subnet_a_id
  private_db_subnet_b_id = module.networking.private_db_subnet_b_id
  rds_security_group_id  = module.security.rds_security_group_id
  db_username            = var.db_username
  db_password            = var.db_password
}