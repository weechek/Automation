terraform {
    required_version = ">=1.10.0"
    required_providers {
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

provider "local" {
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.DO_token
}