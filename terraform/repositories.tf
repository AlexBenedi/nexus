resource "nexus_repository_docker_hosted" "name" {
    for_each = var.docker_repository

    online = each.value.online
    name = each.key

    docker {
        force_basic_auth = each.value.docker.force_basic_auth
        v1_enabled = each.value.docker.v1_enabled
        subdomain = each.value.docker.subdomain
        http_port = each.value.docker.http_port
        https_port = each.value.docker.http_ports
    }

    storage {
        blob_store_name = each.value.storage.blob_store_name
        strict_content_type_validation = each.value.storage.strict_content_type_validation
        write_policy = each.value.storage.write_policy
    }
}