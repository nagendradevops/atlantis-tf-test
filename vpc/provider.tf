# Terraform Block
terraform {
  required_version = "~> 1.6" 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  # backend "s3" {
  #   bucket         = "ed-nonprod-terraform-state"
  #   key            = "ed/vpc/terraform.tfstate"
  #   region         = "us-east-2"
  #   dynamodb_table = "ed_table"
  # }
}

# Provider Block
provider "aws" {
  region  = var.region
  profile = var.profile
  shared_config_files      = ["/home/ec2-user/.aws/conf"]
  shared_credentials_files = ["/home/ec2-user/.aws/credentials"]
  
}
/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/