resource "nexus_security_role" "create_role" {
  for_each = merge(local.users_role, var.teams)

  roleid = each.key
  name = each.key
  description = each.value.description
}


locals {
    users_role = {for key, value in var.users : value.userid => {
        roleid = value.userid
        users = ["${value.userid}"]
        description = "Pesonal team of user ${value.userid}"
    }}
}