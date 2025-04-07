locals {
  whitelist_cidrs = [
    "207.55.92.250/32",  # Henry Skrtich IP
    "71.218.118.153/32", # Alex Berger IP
    "209.197.83.205/32", # Savio Sebastian IP
    "71.121.193.1/32",   # Mark Winsor Home IP
    "23.31.246.1/32",    # Hakes Office IP
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
      description = "Allow SSH from whitelist"
    },
    {
      key         = "HTTP"
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = local.whitelist_cidrs
      description = "Allow HTTP from whitelist"
    },
    {
      key         = "rdp-tcp"
      type        = "ingress"
      from_port   = 3389
      to_port     = 3389
      protocol    = "tcp"
      cidr_blocks = local.whitelist_cidrs
      description = "Allow RDP (tcp) from whitelist"
    },
    {
      key         = "rdp-udp"
      type        = "ingress"
      from_port   = 3389
      to_port     = 3389
      protocol    = "udp"
      cidr_blocks = local.whitelist_cidrs
      description = "Allow RDP (udp) from whitelist"
    },
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
      cidr_blocks = local.whitelist_cidrs # ["0.0.0.0/0"] #TODO: Switch to allow all access before going live
      description = "Allow HTTP from anywhere"
    },
    {
      key         = "HTTPS"
      type        = "ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = local.whitelist_cidrs # ["0.0.0.0/0"] #TODO: Switch to allow all access before going live
      description = "Allow HTTPS from anywhere"
    }
  ]

  vpc_id = module.vpc.vpc_id
}
