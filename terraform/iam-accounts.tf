locals {
  users = {
    henry-skrtich = {
      email  = "hskrtich@soaringtech.com",
      groups = ["admin"],
      alarms = true,
    },
    alex-berger = {
      email  = "aberger@soaringtech.com",
      groups = ["admin"],
      alarms = false,
    },
    justin-davis = {
      email  = "justin@soaringtech.com",
      groups = ["admin"],
      alarms = true,
    },
    shawn-sippel = {
      email = "sshawn@geppifamilyenterprises.com",
      groups = [
        "support",
        "billing",
        "readonly",
      ],
      alarms = true,
    }
  }
}

module "users" {
  source = "./modules/iam-user"

  for_each = local.users

  name   = each.value.email
  groups = each.value.groups
}
