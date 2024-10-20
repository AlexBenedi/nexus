users = {
  user_1 = {
    email = "prueba@gmail.com"
    firstname = "hola"
    lastname = "adios"
    password = "pass"
    userid = "user_1"
  }

  user_2 = {
    email = "sec@gmail.com"
    firstname = "sec"
    lastname = "sec"
    password = "pass"
    userid = "user_2"
  }

  user_3 = {
    email = "tres@gmail.com"
    firstname = "sec"
    lastname = "sec"
    password = "pass"
    userid = "user_3"
  }

  user_4 = {
    email = "4@gmail.com"
    firstname = "sec"
    lastname = "sec"
    password = "pass"
    userid = "user_4"
  }
}

teams = {
  team_uno = {
    users = ["user_1"]
    description = "team 1"
  }

  team_dos = {
    users = ["user_2"]
    description = "team 2"
  }
  
  team_tres = {
    users = ["user_1", "user_2"]
    description = "team 1 y 2"
  }

  team_cuatro = {
    users = ["user_3"]
    description = "team 3"
  }
}

docker_repository = {
  repo_uno = {
    docker = {
      force_basic_auth = true
      v1_enabled = false
      http_port = 8083
    }

    access = {
      team_uno = "read"
      team_dos = "write"
      team_cuatro = "read"
    }
  }

  repo_dos = {
    docker = {
      force_basic_auth = true
      v1_enabled = false
      http_port = 8084
    }

    access = {
      team_uno = "write"
      team_tres = "read"
      user_4 = "read"
    }
  }

}