module "enforce_mfa" {
  source  = "terraform-module/enforce-mfa/aws"
  version = "~> 1.0"

  policy_name = "managed-mfa-enforce"
  account_id  = local.account_id
  groups      = [for g in module.groups : g.name]

  manage_own_signing_certificates = true
  manage_own_ssh_public_keys      = true
  manage_own_git_credentials      = true
}
