terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.33.0" # Terraform AWS provider version
    }
  }

  backend "s3" {
    bucket       = "devsecops-terraform-remote-state" # Replace with your unique bucket name
    key          = "terraform-eks-sg-rules"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
}
