output "sg_developers_id" {
  value = aws_security_group.developers-sg.id
}

output "sg_bastion_id" {
  value = aws_security_group.ec2-bastion-sg.id
}

output "sg_web_public_id" {
  value = aws_security_group.web-public-sg.id
}

output "sg_api_private_id" {
  value = aws_security_group.api-private-sg.id
}


output "sg_db_private_id" {
  value = aws_security_group.db-private-sg.id
}
