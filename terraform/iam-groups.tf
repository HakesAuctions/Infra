locals {
  groups = {
    admin = [
      "arn:aws:iam::aws:policy/AdministratorAccess",
    ],
    support = [
      # ec2_start_stop_reboot policy is added elsewhere
      "arn:aws:iam::aws:policy/EC2InstanceConnect",
      "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    ],
    billing = [
      "arn:aws:iam::aws:policy/job-function/Billing",
    ],
    readonly = [
      "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
      "arn:aws:iam::aws:policy/AmazonRoute53DomainsReadOnlyAccess",
      "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess",
      "arn:aws:iam::aws:policy/AmazonRDSPerformanceInsightsReadOnly",
      "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess",
    ],
  }
}

module "groups" {
  source = "./modules/iam-group"

  for_each = local.groups

  name        = each.key
  policy_arns = each.value
}
