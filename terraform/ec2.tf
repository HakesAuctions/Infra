locals {
  app_ec2 = {
    app01 = {
      instance_type   = "t3.small" #TODO: Switch to t3.xlarge before going live
      ami             = local.windows_server_ami
      security_groups = [module.sg_whitelist.id]
      subnet          = module.dynamic_subnets.public_subnet_ids[0]
    },
    app02 = {
      instance_type   = "t3.small"
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

  ssh_key_pair    = aws_key_pair.rsa.key_name
  instance_type   = each.value.instance_type
  vpc_id          = module.vpc.vpc_id
  security_groups = each.value.security_groups
  subnet          = each.value.subnet

  associate_public_ip_address = true
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

  ssh_key_pair    = aws_key_pair.rsa.key_name
  instance_type   = each.value.instance_type
  vpc_id          = module.vpc.vpc_id
  security_groups = each.value.security_groups
  subnet          = each.value.subnet

  associate_public_ip_address = true
}

resource "aws_route53_record" "backend_ec2" {
  for_each = local.backend_ec2

  zone_id = aws_route53_zone.hakes_com.zone_id
  name    = each.key
  type    = "A"
  ttl     = 300
  records = [module.backend_ec2[each.key].public_ip]
}
