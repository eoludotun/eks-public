########################################
# EC2 public instance 
# bastion server
resource "aws_instance" "bastion-ec2" {
  instance_type = "t3.micro"
  ami = "ami-0cd88166878525f29" # (Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type)
  subnet_id = var.web_subnet_id_bastion
  security_groups = [var.sg_bastion_id]
  key_name = var.ssh_key_pair
  disable_api_termination = false
  ebs_optimized = false
  root_block_device {
    volume_size = "10"
  }

  tags = {
    "Name" = "${var.prefix}-bastion-ec2",
    "cliente" = var.client,
    "ambiente" = "dev",
    "type" = "bastion"
  }
}


########################################
# EC2 API private instances 
# 
resource "aws_instance" "api-private-ec2" {
  instance_type = "t3.micro"
  ami = "ami-0cd88166878525f29" # (Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type)
  subnet_id = var.api_subnet_id
  security_groups = [var.sg_api_private_id]
  key_name = var.ssh_key_pair
  disable_api_termination = false
  ebs_optimized = false
  root_block_device {
    volume_size = "10"
  }

  tags = {
    "Name" = "${var.prefix}-api-private-ec2",
    "cliente" = var.client,
    "ambiente" = "dev",
    "type" = "bastion"
  }
}



########################################
# EC2 API private instances 
#
resource "aws_instance" "db-private-ec2" {
  instance_type = "t3.micro"
  ami = "ami-0cd88166878525f29" # (Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type)
  subnet_id = var.db_subnet_id
  security_groups = [var.sg_db_private_id]
  key_name = var.ssh_key_pair
  disable_api_termination = false
  ebs_optimized = false
  root_block_device {
    volume_size = "10"
  }

  tags = {
    "Name" = "${var.prefix}-db-private-ec2",
    "cliente" = var.client,
    "ambiente" = "dev",
    "type" = "bastion"
  }
}
