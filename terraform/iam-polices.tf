resource "aws_iam_policy" "ec2_start_stop_reboot" {
  name        = "EC2StartStopRebootPolicy"
  description = "Allows start, stop, and reboot of EC2 instances"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:RebootInstances"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "ec2_start_stop_reboot" {
  group      = module.groups["support"].name
  policy_arn = aws_iam_policy.ec2_start_stop_reboot.arn
}

resource "aws_iam_policy" "cost_explorer_readonly" {
  name        = "CostExplorerReadOnly"
  description = "Allows read only access to cost explorer"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ce:Get*",
          "ce:List*"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "cost_explorer_readonly" {
  group      = module.groups["billing"].name
  policy_arn = aws_iam_policy.cost_explorer_readonly.arn
}
