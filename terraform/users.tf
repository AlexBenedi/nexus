

resource "nexus_security_user" "create" {
  for_each = var.users

  userid    = each.value.userid
  firstname = each.value.firstname
  lastname  = each.value.lastname
  email     = each.value.email
  password  = each.value.password
  roles     = concat(lookup(local.roles_per_user, each.key, []), 
    ["${each.value.userid}", "nx-base-role"])
  status    = each.value.status

  lifecycle {
    ignore_changes = [ firstname, lastname, email, password ]
  }

  depends_on = [ nexus_security_role.create_role ]
}


locals {
  _roles_user = flatten([
    for name, info in var.teams : [
      for user in info.users : {
        user = user
        team = name
      }
    ]
  ])

  roles_per_user = {
    for role in local._roles_user : role.user => role.team...
  }
}

