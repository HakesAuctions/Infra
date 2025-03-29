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
  }
}

module "users" {
  source = "./modules/iam-user"

  for_each = local.users

  name   = each.value.name
  groups = each.value.groups
}
