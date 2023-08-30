# Some outputs

# Public IP address of the EC2
output "instance_public_ip" {
  description = "The public IP address of the EC2 instance."
  value       = aws_instance.daniils-final-instance.public_ip
}

# Private IP address of the EC2
output "instance_private_ip" {
  description = "The private IP address of the EC2 instance."
  value       = aws_instance.daniils-final-instance.private_ip
}

# The ID of the security group
output "security_group_id" {
  description = "The ID of the security group."
  value       = aws_security_group.daniils-final-sg.id
}

# The ID of the VPC
output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_security_group.daniils-final-sg.vpc_id
}

# The name of the EC2 instance
output "instance_name" {
  description = "The name of the EC2 instance."
  value       = aws_instance.daniils-final-instance.tags.Name
}
