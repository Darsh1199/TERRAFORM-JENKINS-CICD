resource "docker_image" "zomato" {
  name = "sevenajay/zomato:latest"
}

resource "docker_image" "netflix" {
  name = "sevenajay/netflix:latest"
}

resource "docker_container" "zomato" {
  name  = "zomato"
  image = docker_image.zomato.image_id

  ports {
    internal = 3000
    external = 3000
  }

  restart = "unless-stopped"
}

resource "docker_container" "netflix" {
  name  = "netflix"
  image = docker_image.netflix.image_id

  ports {
    internal = 80
    external = 8081
  }

  restart = "unless-stopped"
}
