terraform {
    required_version = ">=1.10.0"
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            version = "3.0.2"
        }
        local = {
            source = "hashicorp/local"
            version = "2.5.2"
        }
        digitalocean = {
            source = "onfocusio/digitalocean"
            version = "2.10.2"
    }
    }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

provider "local" {
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "dop_v1_019402b17e160288a2046c37cdf5c000d6af071cfc97c99770528b079962bbbc"
}