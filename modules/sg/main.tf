########################################
# Security group to allow access from
# developers
# 
resource "aws_security_group" "developers-sg" {
  name = "${var.prefix}-developers-sg"
  description = "Developer team inbound access"
  vpc_id = var.vpc_main_pub_id
  ingress {
    cidr_blocks = ["191.183.197.195/32"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
    description = "inbound ssh for Fields"
  }
  ingress {
    cidr_blocks = ["191.183.197.195/32"]
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    description = "inbound Postgres for Fields"
  }
  ingress {
    cidr_blocks = ["191.187.43.229/32"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
    description = "inbound ssh for Tevao"
  }
  ingress {
    cidr_blocks = ["191.187.43.229/32"]
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    description = "inbound Postgres for Tevao"
  }
  ingress {
    cidr_blocks = ["186.204.118.100/32"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
    description = "inbound ssh for Spaka"
  }
  ingress {
    cidr_blocks = ["186.204.118.100/32"]
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    description = "inbound Postgres for Spaka"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
    description = "Outbound communication to anywhere"
  }

  tags = {
    "Name" = "${var.prefix}-developers-sg",
    "cliente" = var.client,
    "ambiente" = "dev"
  }
}

########################################
# Security group to allow access to the
# bastion server. All SSH setup must be
# executed manually
resource "aws_security_group" "ec2-bastion-sg" {
  name = "${var.prefix}-ec2-bastion-sg"
  description = "EC2 bastion inbound access"
  vpc_id = var.vpc_main_pub_id
  ingress {
    security_groups = [aws_security_group.developers-sg.id]
    from_port = 22
    to_port = 22
    protocol = "tcp"
    description = "Inbound ssh from Developers"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
    description = "Outbound communication to anywhere"
  }

  tags = {
    "Name" = "${var.prefix}-ec2-bastion-sg",
    "cliente" = var.client,
    "ambiente" = "dev"
  }
}

########################################
# Security group to allow access to the
# EKS Cluster of Web Apps. The cluster 
# faces the internet (so far)
resource "aws_security_group" "web-public-sg" {
  name = "${var.prefix}-web-public-sg"
  description = "Web EKS inbound access (internet facing)"
  vpc_id = var.vpc_main_pub_id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 80
    to_port = 80
    protocol = "tcp"
    description = "Inbound HTTP connections"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 2376
    to_port = 2376
    protocol = "tcp"
    description = "Inbound Rancher connections"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 443
    to_port = 443
    protocol = "tcp"
    description = "Inbound HTTPS connections"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
    description = "Outbound communication to anywhere"
  }

  tags = {
    "Name" = "${var.prefix}-web-public-sg",
    "cliente" = var.client,
    "ambiente" = "dev"
  }
}


########################################
# Security group to allow access to the
# EKS Cluster of the API. The cluster 
# resides in a private subnet
resource "aws_security_group" "api-private-sg" {
  name = "${var.prefix}-api-private-sg"
  description = "API EKS inbound access (private)"
  vpc_id = var.vpc_main_pub_id
  ingress {
    security_groups = [aws_security_group.web-public-sg.id]
    from_port = 80
    to_port = 80
    protocol = "tcp"
    description = "Web inbound HTTP connections"
  }
  ingress {
    security_groups = [aws_security_group.web-public-sg.id]
    from_port = 2376
    to_port = 2376
    protocol = "tcp"
    description = "Web inbound Rancher connections"
  }
  ingress {
    security_groups = [aws_security_group.web-public-sg.id]
    from_port = 443
    to_port = 443
    protocol = "tcp"
    description = "Web inbound HTTPS connections"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
    description = "Outbound communication to anywhere"
  }
  tags = {
    "Name" = "${var.prefix}-api-private-sg",
    "cliente" = var.client,
    "ambiente" = "dev"
  }
}


########################################
# Security group to allow access to the
# RDS Multi-AZ cluster. The cluster is
# private
resource "aws_security_group" "db-private-sg" {
  name = "${var.prefix}-db-private-sg"
  description = "RDS inbound access (private)"
  vpc_id = var.vpc_main_pub_id
  ingress {
    security_groups = [aws_security_group.api-private-sg.id]
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    description = "API inbound Postgres connections"
  }
  ingress {
    security_groups = [aws_security_group.ec2-bastion-sg.id]
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    description = "API inbound Postgres connections"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
    description = "Outbound communication to anywhere"
  }
  tags = {
    "Name" = "${var.prefix}-db-private-sg",
    "cliente" = var.client,
    "ambiente" = "dev"
  }
}
