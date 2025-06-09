locals {
  users = {
    henry-skrtich = {
      email  = "hskrtich@soaringtech.com",
      groups = ["admin"],
    },
    alex-berger = {
      email  = "aberger@soaringtech.com",
      groups = ["admin"],
    },
    justin-davis = {
      email  = "justin@soaringtech.com",
      groups = ["admin"],
    },
    shawn-sippel = {
      email = "sshawn@geppifamilyenterprises.com",
      groups = [
        "support",
        "readonly",
      ],
    },
    alex-winter = {
      email = "walex@hakes.com",
      groups = [
        "billing",
      ],
    },
  }
}

module "users" {
  source = "./modules/iam-user"

  for_each = local.users

  name   = each.value.email
  groups = each.value.groups
}
