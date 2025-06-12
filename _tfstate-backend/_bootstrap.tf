# This TF file setups the bucket and lock table for running TF files
# It is not setup to use a backend on purpous since this is whats
# create the needed backend.

locals {
  default_aws_tags = {
    Environment = terraform.workspace
    ManagedBy   = "terraform"
    Repository  = "https://github.com/HakesAuctions/Infra/_tfstate-backend"
  }
}

terraform {
  required_version = ">= 1.10"

  required_providers {
    aws = {
      version = "~> 5.0"
      source  = "hashicorp/aws"
    }
  }

  backend "s3" {
    profile = "hakes-admin"
    region  = "us-east-1"
    bucket  = "hakes-prd-terraform-state"
    key     = "tfstate-backend.tfstate"
    encrypt = "true"

    dynamodb_table = "hakes-prd-terraform-state-lock"
  }
}

provider "aws" {
  profile = "hakes-admin"
  region  = "us-east-1"

  default_tags { tags = local.default_aws_tags }
}
