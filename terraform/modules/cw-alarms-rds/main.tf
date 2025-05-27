locals {
  name = var.name
}

resource "aws_cloudwatch_metric_alarm" "rds_cpu_high" {
  alarm_name = "RDS ${local.name} - High CPU Usage"

  alarm_description = "RDS CPU usage is over 90%"

  comparison_operator = "GreaterThanThreshold"
  period              = 60
  evaluation_periods  = 3

  metric_name = "CPUUtilization"
  namespace   = "AWS/RDS"
  statistic   = "Average"
  threshold   = 90

  alarm_actions = var.alarm_actions
  ok_actions    = var.ok_actions

  dimensions = {
    DBInstanceIdentifier = var.instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_credit_low" {
  alarm_name = "RDS ${local.name} - Low CPU Credit Balance"

  alarm_description = "RDS CPU credit balance is under 100"

  comparison_operator = "LessThanThreshold"
  period              = 60
  evaluation_periods  = 3

  metric_name = "CPUCreditBalance"
  namespace   = "AWS/RDS"
  statistic   = "Average"
  threshold   = 100

  alarm_actions = var.alarm_actions
  ok_actions    = var.ok_actions

  dimensions = {
    DBInstanceIdentifier = var.instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_disk_low" {
  alarm_name = "RDS ${local.name} - Low Disk Space"

  alarm_description = "RDS free disk space is under 20GB"

  comparison_operator = "LessThanThreshold"
  period              = 60
  evaluation_periods  = 3

  metric_name = "FreeStorageSpace"
  namespace   = "AWS/RDS"
  statistic   = "Average"
  threshold   = 20714151936 # 20GB in bytes

  alarm_actions = var.alarm_actions
  ok_actions    = var.ok_actions

  dimensions = {
    DBInstanceIdentifier = var.instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "disk_queue_depth_too_high" {
  alarm_name = "RDS ${local.name} - Disk Queue Depth Too High"

  alarm_description = "Disk queue depth is too high"

  comparison_operator = "GreaterThanThreshold"
  period              = 60
  evaluation_periods  = 3

  metric_name = "DiskQueueDepth"
  namespace   = "AWS/RDS"
  statistic   = "Average"
  threshold   = 64

  alarm_actions = var.alarm_actions
  ok_actions    = var.ok_actions

  dimensions = {
    DBInstanceIdentifier = var.instance_id
  }
}
