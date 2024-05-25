#Creation of VPC
module "my-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = var.vpc_name
  cidr                 = var.vpc_cidr
  azs                  = data.aws_availability_zones.azs.names
  public_subnets       = var.public_subnets
  enable_dns_hostnames = true

  tags = {
    Name        = "jenkins-vpc"
    Terraform   = "true"
    Environment = "Test"
  }

  public_subnet_tags = {
    Name = "my-public-subnet"
  }
}

#Creation of Security Group
module "my-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = module.my-vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outbound traffic"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  tags = {
    Name        = "jenkins-sg"
    Terraform   = true
    Environment = "Test"
  }
}

#Creation of EC2 Instance
module "my-ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  for_each = { for idx, instance_name in var.number_of_instances : idx => instance_name }

  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  monitoring                  = true
  vpc_security_group_ids      = [module.my-sg.security_group_id]
  subnet_id                   = module.my-vpc.public_subnets[0]
  associate_public_ip_address = true
  availability_zone           = data.aws_availability_zones.azs.names[0]
  user_data                   = file("jenkins-install.sh")
  tags = {
    Name        = "jenkins-server-${each.key + 1}"
    description = "Name to be used on EC2 instance created"
    Terraform   = true
    Environment = "Test"
  }
  depends_on = [module.my-sg]
}