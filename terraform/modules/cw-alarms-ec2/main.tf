locals {
  name = "${var.namespace}-${var.stage}-${var.name}"
}

resource "aws_cloudwatch_metric_alarm" "ec2_cpu_high" {
  alarm_name = "EC2 ${local.name} - High CPU Usage"

  alarm_description = "EC2 CPU usage is over 90%"

  comparison_operator = "GreaterThanThreshold"
  period              = var.period
  evaluation_periods  = var.evaluations

  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"
  statistic   = "Average"
  threshold   = 90

  alarm_actions = var.alarm_actions
  ok_actions    = var.ok_actions

  dimensions = {
    InstanceId = var.instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "ec2_credit_low" {
  alarm_name = "EC2 ${local.name} - Low CPU Credit Balance"

  alarm_description = "EC2 CPU credit balance under 100"

  comparison_operator = "LessThanThreshold"
  period              = var.period
  evaluation_periods  = var.evaluations

  metric_name = "CPUCreditBalance"
  namespace   = "AWS/EC2"
  statistic   = "Average"
  threshold   = 100

  alarm_actions = var.alarm_actions
  ok_actions    = var.ok_actions

  dimensions = {
    InstanceId = var.instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "ec2_memory_high" {
  alarm_name = "EC2 ${local.name} - High Memory Usage"

  alarm_description = "EC2 memory usage is over 90%"

  comparison_operator = "GreaterThanThreshold"
  period              = var.period
  evaluation_periods  = var.evaluations

  metric_name = "Memory % Committed Bytes In Use"
  namespace   = "CWAgent"
  statistic   = "Average"
  threshold   = 90

  alarm_actions = var.alarm_actions
  ok_actions    = var.ok_actions

  dimensions = {
    InstanceId = var.instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "ec2_disk_low" {
  alarm_name = "EC2 ${local.name} - Low Disk Space"

  alarm_description = "EC2 free disk space is under 10%"

  comparison_operator = "LessThanThreshold"
  period              = var.period
  evaluation_periods  = var.evaluations

  metric_name = "LogicalDisk % Free Space"
  namespace   = "CWAgent"
  statistic   = "Average"
  threshold   = 10

  alarm_actions = var.alarm_actions
  ok_actions    = var.ok_actions

  dimensions = {
    InstanceId = var.instance_id
  }
}
