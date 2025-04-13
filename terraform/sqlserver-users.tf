locals {
  user_list = [
    "HakesAppDBWriter",
    "HakesAppDBReadOnly",
    "NewsManagerDBWriter",
    "NewsManagerDBReadOnly",
    "WebstoreDBWriter",
    "WebstoreDBReadOnly",
  ]
}

module "appdb_passwords" {
  source  = "terraform-aws-modules/secrets-manager/aws"
  version = "1.3.1"

  for_each = { for u in local.user_list : u => u }

  # Secret
  name        = "${each.value}-${local.name_postfix}"
  description = "App DB Admin Password"

  recovery_window_in_days = 30

  # Policy
  create_policy       = true
  block_public_policy = true
  policy_statements = {
    read = {
      sid = "AllowAccountRead"
      principals = [{
        type        = "AWS"
        identifiers = ["arn:aws:iam::${local.aws_id}:root"]
      }]
      actions   = ["secretsmanager:GetSecretValue"]
      resources = ["*"]
    }
  }

  create_random_password = true
  random_password_length = 32

  random_password_override_special = "!%^*_+"
}
