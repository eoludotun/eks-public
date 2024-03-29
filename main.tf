


terraform {
  # é a versão que os exemplos do terraform são feitos
  required_version = ">=0.13.1"
  required_providers {
    aws   = ">=3.74.0"
    local = ">=2.1.0"
  }
  #backend "s3" {
  # bucket = "aws-terraform-poc"
  #key = "terraform.tfstate"
  #region = "sa-east-1"
  #}
}

provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source = "./modules/vpc"
  prefix = var.prefix
  client = var.client

  web_subnets_size = var.web_subnets_size
  api_subnets_size = var.api_subnets_size
  db_subnets_size  = var.db_subnets_size
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


#module "ec2" {
#  source = "./modules/ec2"
#  prefix = var.prefix
#  client = var.client

# vpc_main_pub_id = module.vpc.vpc_main_pub_id

#web_subnet_id_bastion = module.vpc.web_subnet_id_bastion
#api_subnet_id = module.vpc.api_subnet_id
#db_subnet_id = module.vpc.db_subnet_id

#sg_developers_id = module.sg.sg_developers_id
#sg_bastion_id = module.sg.sg_bastion_id
#sg_web_public_id = module.sg.sg_web_public_id
#sg_api_private_id = module.sg.sg_api_private_id
#sg_db_private_id = module.sg.sg_db_private_id

#ssh_key_pair = module.ssh.ssh_key_pair
#}

#module "rds" {
# source = "./modules/rds"
#prefix = var.prefix
#client = var.client

# vpc_main_pub_id = module.vpc.vpc_main_pub_id

#db_subnet_ids = module.vpc.db_subnet_ids
#sg_db_private_id = module.sg.sg_db_private_id

#engine = var.engine
#engine_version = var.engine_version
#username = var.username
#db_name = var.db_name
#port = var.port
#}


module "eks" {
  source = "./modules/eks"
  prefix = var.prefix
  client = var.client
  #cluster_version                 = 1.21
  vpc_main_pub_id = module.vpc.vpc_main_pub_id

  retention_days = var.retention_days

  web_subnet_ids   = module.vpc.api_subnet_ids
  web_cluster_name = var.web_cluster_name

  # --- node size----------
  web_desired_size = var.web_desired_size
  web_max_size     = var.web_max_size
  web_min_size     = var.web_min_size
  sg_web_public_id = module.sg.sg_web_public_id
}









    
    
    
    
    























# terraform {
#   # é a versão que os exemplos do terraform são feitos
#   required_version = ">=0.13.1"
#   required_providers {
#     aws = ">=3.74.0"
#     local = ">=2.1.0"
#   }
#   backend "s3" {
#     bucket = "aws-terraform-poc"
#     key = "terraform.tfstate"
#     region = "sa-east-1"
#   }
# }

# provider "aws" {
#   region = "sa-east-1"
# }

# module "vpc" {
#   source = "./modules/vpc"
#   prefix = var.prefix
#   client = var.client

#   web_subnets_size = var.web_subnets_size
#   api_subnets_size = var.api_subnets_size
#   db_subnets_size = var.db_subnets_size
# }


# module "ssh" {
#   source = "./modules/ssh"
#   prefix = var.prefix
#   client = var.client
# }


# module "sg" {
#   source = "./modules/sg"
#   prefix = var.prefix
#   client = var.client

#   vpc_main_pub_id = module.vpc.vpc_main_pub_id
# }


# module "ec2" {
#   source = "./modules/ec2"
#   prefix = var.prefix
#   client = var.client

#   vpc_main_pub_id = module.vpc.vpc_main_pub_id

#   web_subnet_id_bastion = module.vpc.web_subnet_id_bastion
#   api_subnet_id = module.vpc.api_subnet_id
#   db_subnet_id = module.vpc.db_subnet_id

#   sg_developers_id = module.sg.sg_developers_id
#   sg_bastion_id = module.sg.sg_bastion_id
#   sg_web_public_id = module.sg.sg_web_public_id
#   sg_api_private_id = module.sg.sg_api_private_id
#   sg_db_private_id = module.sg.sg_db_private_id

#   ssh_key_pair = module.ssh.ssh_key_pair
# }

# module "rds" {
#   source = "./modules/rds"
#   prefix = var.prefix
#   client = var.client

#   # vpc_main_pub_id = module.vpc.vpc_main_pub_id

#   db_subnet_ids = module.vpc.db_subnet_ids
#   sg_db_private_id = module.sg.sg_db_private_id

#   engine = var.engine
#   engine_version = var.engine_version
#   username = var.username
#   db_name = var.db_name
#   port = var.port
# }


# module "eks" {
#   source = "./modules/eks"
#   prefix = var.prefix
#   client = var.client

#   vpc_main_pub_id = module.vpc.vpc_main_pub_id

#   retention_days = var.retention_days

#   web_subnet_ids = module.vpc.web_subnet_ids
#   web_cluster_name = var.web_cluster_name
#   web_desired_size = var.web_desired_size
#   web_max_size = var.web_max_size
#   web_min_size = var.web_min_size
#   sg_web_public_id = module.sg.sg_web_public_id
# }
