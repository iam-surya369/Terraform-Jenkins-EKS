terraform {
  backend "s3" {
    bucket = "surya-terraform-bucket"
    key    = "Terraform-Jenkins-EKS/terraform.tfstate"
    region = "us-east-1"
  }
}