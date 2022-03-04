resource "aws_db_subnet_group" "db-subnet-grp" {
  name = "${var.prefix}-db-subnet-grp"
  # subnet_ids = [aws_subnet.api-subnets[0].id, aws_subnet.api-subnets[1].id]
  subnet_ids = var.db_subnet_ids
  description = "group of subnets to allow Multi AZ"

  tags = {
    "Name" = "${var.prefix}-db-subnet-grp",
    "cliente" = var.client,
    "ambiente" = "prod"
  }
}


resource "aws_db_instance" "db" {
  identifier = "${var.prefix}-db-instance"
  allocated_storage = 5
  max_allocated_storage = 30
  deletion_protection = false
  skip_final_snapshot = true
  publicly_accessible = false
  instance_class = "db.t3.medium"
  engine = var.engine
  engine_version = var.engine_version
  username = var.username
  db_name = var.db_name
  port = var.port
  password = "dEUaC]xL&=8e?;nv2,"
  # engine = "postgres"
  # engine_version = "14.1"
  # username = "d3bid"
  # password = "dEUaC]xL&=8e?;nv2,"
  # db_name = "bid"
  # port = "5432"
  vpc_security_group_ids = [var.sg_db_private_id]
  db_subnet_group_name = aws_db_subnet_group.db-subnet-grp.name

  tags = {
    "Name" = "${var.prefix}-db",
    "cliente" = var.client,
    "ambiente" = "prod"
  }
} 
