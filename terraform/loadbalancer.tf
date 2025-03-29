module "alb" {
  source  = "cloudposse/alb/aws"
  version = "v2.2.2"

  namespace = local.namespace
  stage     = terraform.workspace
  name      = "app"

  vpc_id             = module.vpc.vpc_id
  security_group_ids = [module.vpc.vpc_default_security_group_id]
  subnet_ids         = module.dynamic_subnets.public_subnet_ids
  internal           = false
  http_enabled       = true
  http_redirect      = true
  https_enabled      = true
  http2_enabled      = true
  idle_timeout       = 60
  ip_address_type    = "ipv4"

  certificate_arn = module.cert_hakes_com.arn

  cross_zone_load_balancing_enabled = true
  deletion_protection_enabled       = true

  # access_logs_enabled = var.access_logs_enabled
  # deregistration_delay                    = var.deregistration_delay
  # health_check_path                       = var.health_check_path
  # health_check_timeout                    = var.health_check_timeout
  # health_check_healthy_threshold          = var.health_check_healthy_threshold
  # health_check_unhealthy_threshold        = var.health_check_unhealthy_threshold
  # health_check_interval                   = var.health_check_interval
  # health_check_matcher                    = var.health_check_matcher
  target_group_port        = 80
  target_group_target_type = "instance"

  #TODO: Need to check if this is needed
  # stickiness = {
  #   cookie_duration = 60?
  #   enabled         = true
  # }
}

resource "aws_route53_record" "base" {
  zone_id = aws_route53_zone.hakes_com.zone_id
  name    = "aws" #TODO: Replace with base domain when ready to switch over
  type    = "A"

  alias {
    name    = module.alb.alb_dns_name
    zone_id = module.alb.alb_zone_id

    evaluate_target_health = true
  }
}

# #TODO: Disabled until switch over
# resource "aws_route53_record" "www" {
#   zone_id = aws_route53_zone.hakes_com.zone_id
#   name    = "www"
#   type    = "A"

#   alias {
#     name    = module.alb.alb_dns_name
#     zone_id = module.alb.alb_zone_id

#     evaluate_target_health = true
#   }
# }

module "cert_hakes_com" {
  source  = "cloudposse/acm-request-certificate/aws"
  version = "v0.18.0"

  domain_name = "hakes.com"
  zone_id     = aws_route53_zone.hakes_com.zone_id
  ttl         = "300"

  process_domain_validation_options = true
  subject_alternative_names         = ["*.hakes.com"]
}
