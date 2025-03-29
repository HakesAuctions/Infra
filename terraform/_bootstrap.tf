locals {
  default_aws_tags = {
    Environment = terraform.workspace
    ManagedBy   = "terraform"
    Repo        = "https://github.com/HakesAuctions/Infra/terraform"
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
    region  = "us-east-1"
    bucket  = "hakes-prd-terraform-state"
    key     = "terraform.tfstate"
    profile = "hakes-admin"
    encrypt = "true"

    dynamodb_table = "hakes-prd-terraform-state-lock"
  }
}

provider "aws" {
  profile = "hakes-admin"
  region  = "us-east-1"

  default_tags { tags = local.default_aws_tags }
}

# tflint-ignore: terraform_unused_declarations
data "aws_region" "current" {}
# tflint-ignore: terraform_unused_declarations
data "aws_caller_identity" "current" {}
