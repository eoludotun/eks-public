########################################
# Key pair to aloow SSH to the bastion
# server 
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh" {
  key_name = "${var.prefix}-ec2-kp"
  public_key = tls_private_key.ssh.public_key_openssh
  
  tags = {
    "Name" = "${var.prefix}-ec2-kp",
    "cliente" = var.client,
    "ambiente" = "dev"
  }
}

locals {
  pem = tls_private_key.ssh.private_key_pem
}

resource "local_file" "ssh" {
  filename = "${var.prefix}-ec2-kp.pem"
  content = local.pem
}

resource "null_resource" "ssh" {
  depends_on = [
    local_file.ssh
  ]
  provisioner "local-exec" {
    command = "chmod 400 ${var.prefix}-ec2-kp.pem"
  }
}
