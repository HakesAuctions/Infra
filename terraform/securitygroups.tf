locals {
  whitelist_cidrs = [
    "207.55.92.250/32", # Henry Skrtich Private IP
  ]
}

module "sg_whitelist" {
  source  = "cloudposse/security-group/aws"
  version = "2.2.0"

  namespace = local.namespace
  stage     = terraform.workspace
  name      = "whitelist"

  create_before_destroy = false

  # Allow unlimited egress
  allow_all_egress = true

  rules = [
    {
      key         = "ssh"
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = local.whitelist_cidrs
      description = "Allow SSH from anywhere"
    },
    {
      key         = "HTTP"
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = local.whitelist_cidrs
      description = "Allow HTTP from inside the security group"
    }
  ]

  vpc_id = module.vpc.vpc_id
}

module "sg_loadbalancer" {
  source  = "cloudposse/security-group/aws"
  version = "2.2.0"

  namespace = local.namespace
  stage     = terraform.workspace
  name      = "loadbalancer"

  create_before_destroy = false

  # Allow unlimited egress
  allow_all_egress = true

  rules = [
    {
      key         = "HTTP"
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTP from anywhere"
    },
    {
      key         = "HTTPS"
      type        = "ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTPS from anywhere"
    }
  ]

  vpc_id = module.vpc.vpc_id
}
