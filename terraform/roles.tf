
resource "nexus_security_role" "create_role" {
  for_each = merge(local.users_role, var.teams)

  roleid = each.key
  name = each.key
  description = each.value.description

  privileges = anytrue([ for privilege in local.all_access : privilege.role == each.key
  ]) ? [ "${each.key}-read-privilege", "${each.key}-write-privilege" ] : []
  
  depends_on =[nexus_privilege_wildcard.read_privileges, nexus_privilege_wildcard.write_privileges]
}

resource "nexus_security_role" "base-role" {
  name = "nx-base-role"
  roleid = "nx-base-role"
  description = "Base role for all users"
  privileges = ["nx-userschangepw"]
}

locals {
  users_role = {for key, value in var.users : value.userid => {
    roleid = value.userid
    users = ["${value.userid}"]
    description = "Pesonal team of user ${value.userid}"
  }}
}