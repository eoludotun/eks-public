output "sg_developers_id" {
  value = aws_security_group.developers-sg.id
}

output "sg_bastion_id" {
  value = aws_security_group.ec2-bastion-sg.id
}
