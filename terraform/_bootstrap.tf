locals {
  default_aws_tags = {
    Environment = terraform.workspace
    ManagedBy   = "terraform"
    Repo        = "https://github.com/HakesAuctions/Infra/terraform"
  }

  account_id = "206417140802"
  namespace  = "hakes"
}

terraform {
  required_version = ">= 1.9"

  required_providers {
    aws = {
      version = "~> 5.99"
      source  = "hashicorp/aws"
    }
  }

  backend "s3" {
    profile = "hakes-admin"
    region  = "us-east-1"
    bucket  = "hakes-prd-terraform-state"
    key     = "terraform.tfstate"
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
