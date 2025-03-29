locals {
  ipv4_cidr_block = "10.50.0.0/16"
}

module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "v2.1.1"

  namespace = local.namespace
  stage     = terraform.workspace
  name      = "app"

  ipv4_primary_cidr_block = local.ipv4_cidr_block
}

module "dynamic_subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "v2.4.2"

  namespace = local.namespace
  stage     = terraform.workspace
  name      = "app"
  availability_zones = [
    "${data.aws_region.current.name}a",
    "${data.aws_region.current.name}b",
    #"${data.aws_region.current.name}c",
  ]
  vpc_id          = module.vpc.vpc_id
  igw_id          = [module.vpc.igw_id]
  ipv4_cidr_block = [local.ipv4_cidr_block]
}
