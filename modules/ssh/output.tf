output "ssh_key_pair" {
  description = "Key-pair used to connect to EC2 instances via SSH"
  value = aws_key_pair.ssh.key_name
}
