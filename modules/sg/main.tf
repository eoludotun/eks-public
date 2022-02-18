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
