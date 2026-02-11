terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.66"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::521938783116:role/terraform_admin"
  }
}
