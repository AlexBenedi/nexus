variable "nexus_url" {
    description = "URL de Nexus"
    type        = string
    default     = ""
}

variable "nexus_username" {
    description = "Usuario del admin de Nexus"
    type        = string
    default     = ""
}

variable "nexus_password" {
    description = "Contraseña del admin de Nexus"
    type        = string
    default     = ""
}

variable "users" {
    type = map(object({
        email = string
        firstname = string
        lastname = string
        password = optional(string, "")
        userid = string
        #roles = optional(set(string), [])
        status = optional(string, "active")
    }))
}

variable "teams" {
    type = map(object({
        users = set(string)
        description = optional(string, "")
    }))
}

variable "docker_repository" {
    type = map(object({

        #name = string
        online = optional(bool, true)

        docker = object({
          force_basic_auth = bool
          v1_enabled = bool
          http_port = optional(number)
          http_ports = optional(number)
          subdomain = optional(string)
        })

        storage = object({
          blob_store_name = optional(string, "default")
          strict_content_type_validation = optional(bool, false)
          write_policy = optional(string) 
          latest_policy = optional(bool)
        })

        cleanup = optional(object({
            policy_names = optional(set(string), [])
        }))

        access = optional(set(string), [])
    }))
}

