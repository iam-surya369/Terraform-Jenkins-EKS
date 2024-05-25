#Creation of VPC
module "my-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = var.vpc_name
  cidr                 = var.vpc_cidr
  azs                  = data.aws_availability_zones.azs.names
  public_subnets       = var.public_subnets
  private_subnets      = var.private_subnets
  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true
  tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/elb"               = 1
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"      = 1
  }
}


#Creation of EKS Cluster
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access = true

  vpc_id                   = module.my-vpc.vpc_id
  subnet_ids               = module.my-vpc.private_subnets
  control_plane_subnet_ids = ["subnet-xyzde987", "subnet-slkjf456", "subnet-qeiru789"]

  eks_managed_node_groups = {
    node_group = {
      instance_type = var.nodegroup_instance_type
      min_size      = 1
      max_size      = 3
      desired_size  = 2
    }
  }
  tags = {
    Environment = "Test"
    Terraform   = "true"
  }
}