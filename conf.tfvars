users = {
  prueba = {
    email = "prueba@gmail.com"
    firstname = "hola"
    lastname = "adios"
    password = "pass"
    userid = "prueba"
  }

  segundo = {
    email = "sec@gmail.com"
    firstname = "sec"
    lastname = "sec"
    password = "pass"
    userid = "sec"
  }
}

teams = {
  uno = {
    users = ["prueba"]
    description = "prueba"
  }

  dos = {
    users = ["sec"]
    description = "sec"
  }
  
  tres = {
    users = ["prueba, sec"]
    description = "prueba sec"
  }
}

docker_repository = {
  first = {
    docker = {
      force_basic_auth = true
      v1_enabled = false
      http_port = 8083
    }

    storage = {}

    access = ["uno"]
  }
}