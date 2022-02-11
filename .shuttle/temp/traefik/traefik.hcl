job "traefik" {
  region      = "global"
  datacenters = ["dc1"]
  type        = "system"

  constraint {
    attribute = "${meta.type}"
    value     = "server"
  }

  group "traefik" {
    count = 1

    network {
      port "http" {
        static = 8080
      }
      port "https" {
        static = 443
      }
      port "api" {
        static = 8081
      }
    }

    service {
      name = "traefik"

      check {
        name     = "alive"
        type     = "tcp"
        port     = "http"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "traefik" {
      driver = "docker"

      config {
        image        = "traefik:v2.2"
        network_mode = "host"

        volumes = [
          "local/traefik.toml:/etc/traefik/traefik.toml",
        ]
      }

      template {
        source      = "traefik.toml"
        destination = "local/traefik.toml"
      }

      resources {
        cpu    = 200
        memory = 256
      }
    }
  }
}