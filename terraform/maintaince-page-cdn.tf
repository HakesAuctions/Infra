locals {
  file_map = {
    "index.html" = {
      source       = "./files/maintenance-page/index.html"
      content_type = "text/html"
    }
    "HakesLogo.png" = {
      source       = "./files/maintenance-page/HakesLogo.png"
      content_type = "image/png"
    }
  }
}

module "maintenance_page_certificate" {
  source  = "cloudposse/acm-request-certificate/aws"
  version = "v0.18.0"

  domain_name = "maintenance.hakes.com"
  zone_id     = aws_route53_zone.hakes_com.zone_id
  ttl         = "300"

  process_domain_validation_options = true
  subject_alternative_names = [
    "hakes.com",
    "*.hakes.com",
  ]
}

module "maintenance_page" {
  source  = "cloudposse/cloudfront-s3-cdn/aws"
  version = "v0.97.0"

  namespace = local.namespace
  stage     = terraform.workspace
  name      = "maintenance-page"

  aliases = [
    "maintenance.hakes.com",
  ]
  dns_alias_enabled = true
  parent_zone_id    = aws_route53_zone.hakes_com.zone_id

  external_aliases = [
    "hakes.com",
    "www.hakes.com",
    "app.hakes.com",
  ]

  acm_certificate_arn = module.maintenance_page_certificate.arn

  depends_on = [
    module.maintenance_page_certificate,
  ]
}

resource "aws_s3_object" "maintenance_page_files" {
  for_each = local.file_map

  bucket       = module.maintenance_page.s3_bucket
  key          = each.key
  source       = each.value.source
  content_type = each.value.content_type
  etag         = filemd5(each.value.source)
}

resource "terraform_data" "maintenance_page_clear_cache" {
  lifecycle {
    replace_triggered_by = [
      aws_s3_object.maintenance_page_files,
    ]
  }

  provisioner "local-exec" {
    command = "AWS_PROFILE=hakes-admin aws cloudfront create-invalidation --distribution-id ${module.maintenance_page.cf_id} --paths '/*'"
  }
}
