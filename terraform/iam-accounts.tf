locals {
  users = {
    henry-skrtich = {
      name   = "hskrtich@soaringtech.com",
      groups = ["admin"],
    },
    alex-berger = {
      name   = "aberger@soaringtech.com",
      groups = ["admin"],
    },
    justin-davis = {
      name   = "justin@soaringtech.com",
      groups = ["admin"],
    },
    shawn-sippel = {
      name = "sshawn@geppifamilyenterprises.com",
      groups = [
        "support",
        "billing",
        "readonly",
      ],
    }
    savio-sebastian = {
      name = "ssavio@diamondcomics.com",
      groups = [
        "support",
        "readonly",
      ],
    },
  }
}

module "users" {
  source = "./modules/iam-user"

  for_each = local.users

  name   = each.value.name
  groups = each.value.groups
}
