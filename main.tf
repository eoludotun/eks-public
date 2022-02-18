terraform {
  # é a versão que os exemplos do terraform são feitos
  required_version = ">=0.13.1"
  required_providers {
    aws = ">=3.74.0"
    local = ">=2.1.0"
  }
  # backend "s3" {
  #   bucket = "aws-terraform-poc"
  #   key = "terraform.tfstate"
  #   region = "sa-east-1"
  # }
}

provider "aws" {
  region = "sa-east-1"
}

module "vpc" {
  source = "./modules/vpc"
  prefix = var.prefix
  client = var.client

  web_subnets_size = var.web_subnets_size
  api_subnets_size = var.api_subnets_size
  db_subnets_size = var.db_subnets_size

  web_subnet_ids = module.vpc.web_subnet_ids

  web_subnet_id_bastion = module.vpc.web_subnet_id_bastion
  api_subnet_id_bastion = module.vpc.api_subnet_id_bastion
  db_subnet_id_bastion = module.vpc.db_subnet_id_bastion
}


module "ssh" {
  source = "./modules/ssh"
  prefix = var.prefix
  client = var.client
}


module "sg" {
  source = "./modules/sg"
  prefix = var.prefix
  client = var.client

  vpc_main_pub_id = module.vpc.vpc_main_pub_id

}
