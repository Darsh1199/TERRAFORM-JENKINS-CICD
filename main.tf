resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "web" {
  name  = "web-server"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8080
  }
}
