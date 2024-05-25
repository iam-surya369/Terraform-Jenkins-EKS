variable "aws_region" {
  description = "AWS region"
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

variable "private_subnets" {
  description = "public subnet cidr"
  type        = list(string)
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster"
  type        = string
}

variable "nodegroup_instance_type" {
  description = "type of the instances for node group"
  type        = string
}