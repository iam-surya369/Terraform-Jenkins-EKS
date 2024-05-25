output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.my-vpc.vpc_id
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.my-vpc.public_subnets
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.my-sg.security_group_id
}