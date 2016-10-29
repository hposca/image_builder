variable "aws_owner" {
  description = "ID of the AWS account"
}

variable "region" {
  description = "AWS Region to boot the machine"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Instance type"
  default     = "t2.micro"
}

variable "keypair_name" {
  description = "Name of the Key Pair to use on the instance"
}
