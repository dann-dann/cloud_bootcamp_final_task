# Terraform configuration 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Choosing the provider and region
provider "aws" {
         region = "eu-central-1"
 }

# Creating security grouo
resource "aws_security_group" "daniils-final-sg" {
  name        = "daniils-final-sg"
  description = "Security group for the bootcamp final task (Daniils)"
  vpc_id = "vpc-0c978c7db11ae32e9"

  # Inbound rule [SSH] 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  # Inbound rule [HTTP] 
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  # Inbound rule for [HTTPS]
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #############################
  # Outbound rule [SSH]
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule [HTTP]
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule [HTTPS]
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule [All TCP] 
  egress {
     from_port = 0
     to_port = 65535
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }

}

# Creating EC2 instance
resource "aws_instance" "daniils-final-instance" {
  ami           = "ami-04e601abe3e1a910f" # Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-05-16
  instance_type = "t2.micro"
  key_name      = "daniils-key" 

  # Connecting security group to the instance
  security_groups = [aws_security_group.daniils-final-sg.name]

  tags = {
    Name = "daniils-final-instance"
  }
}

# Trick to save public ip address to inventory.ini
resource "local_file" "inventory" {
  depends_on = [aws_instance.daniils-final-instance]

  # Merging first part with inventory_content variable
  content = "[server]\n${aws_instance.daniils-final-instance.public_ip} ${var.inventory_content}" 
  filename = var.inventory_filename
}