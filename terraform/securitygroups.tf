locals {
  whitelist_cidrs = [
    "207.55.92.250/32",  # Henry Skrtich IPv4
    "71.218.118.153/32", # Alex Berger IP
    "209.197.83.205/32", # Savio Sebastian IP
    "23.31.246.1/32",    # Hakes Office IP

    "207.114.0.0/16",   # Mark Winsor/Diamond Comics
    "71.121.193.92/32", # Mark Winsor
    "71.121.193.1/32",  # Mark Winsor Home IP
  ]

  whitelist_cidrs_ipv6 = [
    "2607:f678:2008:f3d0::/64", # Henry Skrtich IPv6
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
      key              = "ssh"
      type             = "ingress"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = local.whitelist_cidrs
      ipv6_cidr_blocks = local.whitelist_cidrs_ipv6
      description      = "Allow SSH from whitelist"
    },
    {
      key              = "HTTP"
      type             = "ingress"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = local.whitelist_cidrs
      ipv6_cidr_blocks = local.whitelist_cidrs_ipv6
      description      = "Allow HTTP from whitelist"
    },
    {
      key              = "rdp-tcp"
      type             = "ingress"
      from_port        = 3389
      to_port          = 3389
      protocol         = "tcp"
      cidr_blocks      = local.whitelist_cidrs
      ipv6_cidr_blocks = local.whitelist_cidrs_ipv6
      description      = "Allow RDP (tcp) from whitelist"
    },
    {
      key              = "rdp-udp"
      type             = "ingress"
      from_port        = 3389
      to_port          = 3389
      protocol         = "udp"
      cidr_blocks      = local.whitelist_cidrs
      ipv6_cidr_blocks = local.whitelist_cidrs_ipv6
      description      = "Allow RDP (udp) from whitelist"
    },
    {
      key              = "winrm"
      type             = "ingress"
      from_port        = 5986
      to_port          = 5986
      protocol         = "tcp"
      cidr_blocks      = local.whitelist_cidrs
      ipv6_cidr_blocks = local.whitelist_cidrs_ipv6
      description      = "Allow WinRM from whitelist"
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
