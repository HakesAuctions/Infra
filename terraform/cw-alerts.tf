locals {
  billing_threshold = 3500 #USD
}

# Email subscriptions to the alarms is a manual process

module "sns_alarms" {
  source  = "cloudposse/sns-topic/aws"
  version = "v1.2.0"

  name      = "alarms"
  namespace = local.namespace
  stage     = terraform.workspace

  allowed_aws_services_for_sns_published = [
    "cloudwatch.amazonaws.com",
  ]

  encryption_enabled = false
  sqs_dlq_enabled    = false
}

module "app_ec2_alarms" {
  source = "./modules/cw-alarms-ec2"

  for_each = local.app_ec2

  name      = each.key
  namespace = local.namespace
  stage     = terraform.workspace

  instance_id   = module.app_ec2[each.key].id
  alarm_actions = [module.sns_alarms.sns_topic_arn]
  ok_actions    = []
}

module "backend_ec2_alarms" {
  source = "./modules/cw-alarms-ec2"

  for_each = local.backend_ec2

  name      = each.key
  namespace = local.namespace
  stage     = terraform.workspace

  instance_id   = module.backend_ec2[each.key].id
  alarm_actions = [module.sns_alarms.sns_topic_arn]
  ok_actions    = []
}

module "rds_alarms" {
  source = "./modules/cw-alarms-rds"

  name      = module.sqlserver.instance_id
  namespace = local.namespace
  stage     = terraform.workspace

  instance_id   = module.sqlserver.instance_id
  alarm_actions = [module.sns_alarms.sns_topic_arn]
  ok_actions    = []
}

# CloudWatch Billing Alarm
resource "aws_cloudwatch_metric_alarm" "estimated_charges" {
  alarm_name = "estimated-charges"

  alarm_description = "Alarm when AWS charges exceed ${local.billing_threshold} USD"

  comparison_operator = "GreaterThanThreshold"
  period              = "86400" # 24 hours in seconds
  evaluation_periods  = "1"

  metric_name = "EstimatedCharges"
  namespace   = "AWS/Billing"
  statistic   = "Maximum"
  threshold   = local.billing_threshold

  treat_missing_data = "notBreaching"
  alarm_actions      = [module.sns_alarms.sns_topic_arn]
  ok_actions         = []

  dimensions = {
    Currency = "USD"
  }
}
