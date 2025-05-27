locals {
  groups = {
    admin = [
      "arn:aws:iam::aws:policy/AdministratorAccess",
    ],
    support = [
      # ec2_start_stop_reboot policy is added via iam-polices.tf
      "arn:aws:iam::aws:policy/EC2InstanceConnect",
      "arn:aws:iam::aws:policy/AmazonRDSPerformanceInsightsReadOnly",
      "arn:aws:iam::aws:policy/AWSSecurityHubReadOnlyAccess",
      "arn:aws:iam::aws:policy/AWSHealthFullAccess",
      "arn:aws:iam::aws:policy/AWSSupportAccess",
    ],
    billing = [
      # cost_explorer_readonly policy is added via iam-polices.tf
      "arn:aws:iam::aws:policy/job-function/Billing",
      "arn:aws:iam::aws:policy/AWSBudgetsActionsWithAWSResourceControlAccess",
      "arn:aws:iam::aws:policy/CostOptimizationHubReadOnlyAccess",
    ],
    readonly = [ # aws has a group limit of 10 policy attachments
      "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
      "arn:aws:iam::aws:policy/AmazonRoute53ReadOnlyAccess",
      "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess",
      "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess",
      "arn:aws:iam::aws:policy/AWSServiceCatalogAdminReadOnlyAccess",
      "arn:aws:iam::aws:policy/AWSSecurityHubReadOnlyAccess",
      "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
      "arn:aws:iam::aws:policy/CloudFrontReadOnlyAccess",
      "arn:aws:iam::aws:policy/AmazonVPCReadOnlyAccess",
    ],
  }
}

module "groups" {
  source = "./modules/iam-group"

  for_each = local.groups

  name        = each.key
  policy_arns = each.value
}
