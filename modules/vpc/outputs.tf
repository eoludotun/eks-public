output "vpc_main_pub_id" {
  value = aws_vpc.main-pub-vpc.id
}

output "web_subnet_ids" {
  value = aws_subnet.web-subnets[*].id
}

output "api_subnet_ids" {
  value = aws_subnet.api-subnets[*].id
}

output "web_subnet_id_bastion" {
  value = aws_subnet.web-subnets[0].id
}

output "api_subnet_id" {
  value = aws_subnet.api-subnets[0].id
}

output "db_subnet_id" {
  value = aws_subnet.db-subnets[0].id
}
