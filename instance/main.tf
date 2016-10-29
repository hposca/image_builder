provider "aws" {
  region = "${ var.region }"
}

// AMI
data "aws_ami" "docker_builder" {
  most_recent = true
  owners      = ["${ var.aws_owner }"]

  filter {
    name   = "name"
    values = ["docker-image-builder-*"]
  }
}

// Security Group
resource "aws_security_group" "ssh" {
  name        = "ssh"
  description = "Allow SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// Instance
resource "aws_instance" "docker_builder" {
  ami                    = "${ data.aws_ami.docker_builder.id }"
  instance_type          = "${ var.instance_type }"
  key_name               = "${ var.keypair_name }"
  vpc_security_group_ids = ["${ aws_security_group.ssh.id }"]

  tags {
    Name = "Docker Image Builder Instance"
  }
}
