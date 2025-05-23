module "alb" {
  source  = "cloudposse/alb/aws"
  version = "v2.2.2"

  namespace = local.namespace
  stage     = terraform.workspace
  name      = "app"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.dynamic_subnets.public_subnet_ids

  security_group_enabled = false # Disable default SG so we can control who has access via LB
  security_group_ids     = [module.sg_loadbalancer.id]

  internal        = false
  http_enabled    = true
  http_redirect   = true
  https_enabled   = true
  http2_enabled   = true
  idle_timeout    = 60
  ip_address_type = "ipv4"

  certificate_arn = module.cert_hakes_com.arn

  cross_zone_load_balancing_enabled = true
  deletion_protection_enabled       = true

  target_group_port        = 80
  target_group_target_type = "instance"

  # Redirect to maintenance page, uncomment and apply to enable
  # listener_https_redirect = {
  #   port        = "443"
  #   protocol    = "HTTPS"
  #   status_code = "HTTP_302" # temporary redirect
  #   host        = module.maintenance_page.aliases[0]
  # }

  stickiness = {
    cookie_duration = 60 * 20 # 20 Mintues
    enabled         = true
  }
}

module "cert_hakes_com" {
  source  = "cloudposse/acm-request-certificate/aws"
  version = "v0.18.0"

  domain_name = "hakes.com"
  zone_id     = aws_route53_zone.hakes_com.zone_id
  ttl         = "300"

  process_domain_validation_options = true
  subject_alternative_names         = ["*.hakes.com"]
}
