variable "prefix" {}
variable "client" {}

variable "vpc_main_pub_id" {}

variable "ssh_key_pair" {}

variable "web_subnet_id_bastion" {}
variable "api_subnet_id" {}
variable "db_subnet_id" {}

variable "sg_developers_id" {}
variable "sg_bastion_id" {}
variable "sg_web_public_id" {}
variable "sg_api_private_id" {}
variable "sg_db_private_id" {}
