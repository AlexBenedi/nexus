# nexus-automation

## Resumen
El objetivo principal del proyecto es automatizar la gestión de usuarios, equipos y permisos de acceso en un entorno de Nexus Repository Manager utilizando Terraform. Esto permite una configuración consistente y reproducible, facilitando la administración y el control de acceso a los repositorios Docker.

Esta configuracion se ha implementado unicamente para repositorios de tipo Docker, pero facilmente se podria ampliar para cualquier otro tipo de repositorio siempre que se respete las jeraquia de las vairables.

## Puesta en marcha

Crear un fichero ".env" con las variables secretas con el siguiente contenido:
```
TF_VAR_nexus_username=<username>
TF_VAR_nexus_password=<pass>
TF_VAR_nexus_url=<url>
```

Ejecutar los siguientes comandos para cargar las variables de entorno:
```
set -a
source .env
set +a
```

Ejecutar terraform
```
terraform apply -var-file=./../conf.tfvars
```
## Configuracion
La configuracion se plasma en el fichero de variables de entrada llamado conf.tfvars. Esta configuracion se basa en diferentes bloques: "users", "teams" y "docker_repository".

### Usuarios

En este bloque se especifican todos los usuarios que se desean introducir asi como sus propiedades; email, firstname, lastname, password y userid. Este ultimo parametro es opcional introducir, si este no se introduce se cogera el nombre el cual comienza el objeto del nuevo usuario.

A continuacion se muestra un bloque de codigo de ejemplo:

```
users = {
  user_1 = {
    email = "user_1@gmail.com"
    firstname = "user"
    lastname = "1"
    password = "pass"
    userid = "user_1"
  }

  user_2 = {
    email = "user_2@gmail.com"
    firstname = "user"
    lastname = "2"
    password = "pass"
    userid = "user_2"
  }
}
```

### Equipos

En este bloque se definen los equipos ha crear junto con los miembros correspondiente de este (si tiene) y si se quiere una pequeña descripcion del equipo. Cabe destacar que por el momento es imposible añadir roles como miembros de un rol, tan solo se podran introducir usuarios.

A continuacion se muestra un bloque de ejemplo:
```
teams = {

  team_one = {
    users = ["user_2"]
    description = "team 1"
  }
  
  team_two = {
    users = ["user_1", "user_2"]
    description = "team 2"
  }
}
```

Este ejemplo crea 2 equipos diferentes: El equipo "team_one" tendra como miembro "user_2". El equipo "team_two" tendra como miembros seran "user_1" y "user_2".

### Repositorios docker

Como se ha comentado anteriormente, la automatizacion tan solo esta implementada para los repositorios de tipo docker. Para crear estos repositorios hay una serie de información fundamental la cual se tiene que rellenar para poder crear el repositorio.

En la especificacion de los repositorios a crear, sera necesario rellenar informacion fundamental sobre el repositorio y se podra tambien añadir los usuarios y equipos que tendran acceso al repositorio asi como de que tipo.

A continuacion se muestra un bloque de ejemplo:

```
docker_repository = {
  repo_one = {
    docker = {
      force_basic_auth = true
      http_port = 8083
    }

    access = {
      team_one = "read"
      team_two = "read"
      user_4 = "write"
    }
  }
}
```

Este bloque crea un repositorio llamado "repo_one" al cual tendran acceso de lectura los equipos "team_one" y "team_two" y unicamente el usuario "user_4" tendra acceso de escritura. Se establece una autenticacion para poder realizar subidas y bajadas y se establece el puerto 8083 como puerto de acceso para el repositorio.

A continuacion se detallan todas las opciones disponibles para crear repositorios docker. La mayoria de ellas son opcionales y se establece un valor por defecto:

```
docker_repository = {
  repo_example = {

    online = boolean                  # Optional, default: true
    docker = {
      force_basic_auth = boolean      # Optional, default: true
      v1_enabled = boolean            # Optional, default: false
      http_port = int                 # Optional, default: null
      http_ports = string             # Optional, default: null
      subdomain = string              # Optional, default: null
    }
    storage = {                       # Optional
      blob_store_name = string        # Optional, default: default
      strict_content_type_validation  # Optional, default: false
      write_policy = string           # Optional, defult null
    }
    clenup = {                        # Optional
      policy_names = list(string)     # Optional, defult []
    }                         
    access = {}                       # Optional
  }
}
```

