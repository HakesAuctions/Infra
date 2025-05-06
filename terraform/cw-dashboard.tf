resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "HakesApp"

  dashboard_body = templatefile("${path.module}/files/dashboards/HakesApp.json", {
    alb_id       = module.alb.alb_arn_suffix
    app01_id     = module.app_ec2["app01"].id
    app02_id     = module.app_ec2["app02"].id
    backend01_id = module.backend_ec2["backend01"].id
    db_name      = module.sqlserver.instance_id
  })
}
