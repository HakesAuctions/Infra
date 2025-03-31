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

  ssh_key_pair    = aws_key_pair.this.key_name
  instance_type   = each.value.instance_type
  vpc_id          = module.vpc.vpc_id
  security_groups = each.value.security_groups
  subnet          = each.value.subnet
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

  ssh_key_pair    = aws_key_pair.this.key_name
  instance_type   = each.value.instance_type
  vpc_id          = module.vpc.vpc_id
  security_groups = each.value.security_groups
  subnet          = each.value.subnet
}
