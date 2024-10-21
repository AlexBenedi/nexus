# Wildcards privileges

resource "nexus_privilege_wildcard" "read_privileges" {
    for_each = {
        for role, info in local.access_per_role : role => [
            for permission in info : permission.repository
            if permission.permission == "read"
        ]
    }

    name = "${each.key}-read-privilege"
    description = "Privilege read of ${each.key}"
    pattern = "nexus:repository-view:*:${join(",", each.value)}:read,browse"

    depends_on = [ local.access_per_role ]
}

resource "nexus_privilege_wildcard" "write_privileges" {
    for_each = {
        for role, info in local.access_per_role : role => [
            for permission in info : permission.repository
            if permission.permission == "write"
        ]
    }

    name = "${each.key}-write-privilege"
    description = "Privilege write of ${each.key}"
    pattern = "nexus:repository-view:*:${join(",", each.value)}:edit,add,delete"

    depends_on = [ local.access_per_role ]
}

locals {

  docker_access = flatten([
    for key, value in var.docker_repository : [
      for role, permission in value.access : {
        role = role
        permission = permission
        repository = key
        format = "docker"
      }
    ]
  ])

  all_access = concat(local.docker_access)

  access_per_role = {
    for privilege in local.all_access : privilege.role => {
      repository = privilege.repository
      permission = privilege.permission
      format = privilege.format
    }...
  }
}
