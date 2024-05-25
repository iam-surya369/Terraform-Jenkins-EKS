variable "aws_region" {
  description = "aws region"
  type        = string
}

variable "vpc_name" {
  description = "name of the vpc"
  type        = string
}

variable "vpc_cidr" {
  description = "cidr range for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "public subnet cidr"
  type        = list(string)
}

variable "security_group_name" {
  description = "name of the security group"
  type        = string
}

variable "security_group_description" {
  description = "description for security group"
  type        = string
}

variable "number_of_instances" {
  description = "total number of instances"
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance"
}