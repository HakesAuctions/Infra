locals {
  groups = {
    admin = [
      "arn:aws:iam::aws:policy/AdministratorAccess",
    ],
    support = [
      "arn:aws:iam::aws:policy/EC2InstanceConnect", //TODO: Need more policies, maybe a custom one
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
