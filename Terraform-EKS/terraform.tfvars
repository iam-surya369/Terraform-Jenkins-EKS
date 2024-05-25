aws_region              = "us-east-1"
vpc_name                = "EKS-vpc"
vpc_cidr                = "10.0.0.0/16"
public_subnets          = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
private_subnets         = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
cluster_name            = "my-eks-cluster"
cluster_version         = "1.26"
nodegroup_instance_type = "t2.micro"