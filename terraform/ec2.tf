locals {
  app_ec2 = {
    app01 = {
      instance_type   = "t3.xlarge"
      ami             = local.windows_server_ami
      security_groups = [module.sg_whitelist.id]
      subnet          = module.dynamic_subnets.public_subnet_ids[0]
    },
    app02 = {
      instance_type   = "t3.xlarge"
      ami             = local.windows_server_ami
      security_groups = [module.sg_whitelist.id]
      subnet          = module.dynamic_subnets.public_subnet_ids[1]
    },
  }

  backend_ec2 = {
    backend01 = {
      instance_type   = "t3.small"
      ami             = local.windows_server_ami
      security_groups = [module.sg_whitelist.id]
      subnet          = module.dynamic_subnets.public_subnet_ids[0]
    }
  }
}

module "app_ec2" {
  source  = "cloudposse/ec2-instance/aws"
  version = "1.6.1"

  for_each = local.app_ec2

  name      = each.key
  namespace = local.namespace
  stage     = terraform.workspace

  ami = each.value.ami

  root_volume_size = 50
  root_volume_type = "gp3"
  root_iops        = 3000
  root_throughput  = 125

  burstable_mode = "standard" # Disable unlimited mode to limit cost

  ssh_key_pair       = aws_key_pair.rsa.key_name
  instance_type      = each.value.instance_type
  vpc_id             = module.vpc.vpc_id
  security_groups    = each.value.security_groups
  subnet             = each.value.subnet
  ipv6_address_count = 1

  security_group_rules = [
    {
      "cidr_blocks" : [
        "0.0.0.0/0"
      ],
      "description" : "Allow all outbound traffic",
      "from_port" : 0,
      "protocol" : "-1",
      "to_port" : 65535,
      "type" : "egress"

      "source_security_group_id" : null,
    },
    {
      "cidr_blocks" : [],
      "description" : "Allow access from Load Balancer",
      "type" : "ingress",
      "from_port" : 80,
      "to_port" : 80,
      "protocol" : "tcp",

      "source_security_group_id" : module.sg_loadbalancer.id #module.alb.security_group_id
    },
  ]

  disable_api_stop        = true # Instance Stop Protection
  disable_api_termination = true # Instance Termination Protection

  associate_public_ip_address = true
}

resource "aws_iam_role_policy_attachment" "app_ec2_cw_agent" {
  for_each = local.app_ec2

  role       = module.app_ec2[each.key].role
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_route53_record" "app_ec2" {
  for_each = local.app_ec2

  zone_id = aws_route53_zone.hakes_com.zone_id
  name    = each.key
  type    = "A"
  ttl     = 300
  records = [module.app_ec2[each.key].public_ip]
}

resource "aws_lb_target_group_attachment" "app_ec2" {
  for_each = local.app_ec2

  target_group_arn = module.alb.default_target_group_arn
  target_id        = module.app_ec2[each.key].id
  port             = 80
}

module "backend_ec2" {
  source  = "cloudposse/ec2-instance/aws"
  version = "1.6.1"

  for_each = local.backend_ec2

  name      = each.key
  namespace = local.namespace
  stage     = terraform.workspace

  ami = each.value.ami

  root_volume_size = 50
  root_volume_type = "gp3"
  root_iops        = 3000
  root_throughput  = 125

  burstable_mode = "standard" # Disable unlimited mode to limit cost

  ssh_key_pair       = aws_key_pair.rsa.key_name
  instance_type      = each.value.instance_type
  vpc_id             = module.vpc.vpc_id
  security_groups    = each.value.security_groups
  subnet             = each.value.subnet
  ipv6_address_count = 1

  disable_api_termination = true # Instance Termination Protection

  associate_public_ip_address = true
}

resource "aws_iam_role_policy_attachment" "backend_ec2_cw_agent" {
  for_each = local.backend_ec2

  role       = module.backend_ec2[each.key].role
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_route53_record" "backend_ec2" {
  for_each = local.backend_ec2

  zone_id = aws_route53_zone.hakes_com.zone_id
  name    = each.key
  type    = "A"
  ttl     = 300
  records = [module.backend_ec2[each.key].public_ip]
}
