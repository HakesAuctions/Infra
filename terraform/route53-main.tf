resource "aws_route53_record" "base" {
  zone_id = aws_route53_zone.hakes_com.zone_id
  name    = "hakes.com"
  type    = "A"

  alias {
    name    = module.alb.alb_dns_name
    zone_id = module.alb.alb_zone_id

    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.hakes_com.zone_id
  name    = "www.hakes.com"
  type    = "A"

  alias {
    name    = module.alb.alb_dns_name
    zone_id = module.alb.alb_zone_id

    evaluate_target_health = true
  }
}

resource "aws_route53_record" "app" {
  zone_id = aws_route53_zone.hakes_com.zone_id
  name    = "app.hakes.com"
  type    = "A"

  alias {
    name    = module.alb.alb_dns_name
    zone_id = module.alb.alb_zone_id

    evaluate_target_health = true
  }
}
