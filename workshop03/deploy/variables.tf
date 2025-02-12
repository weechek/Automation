variable DO_token {
    type = string
    description = "DO_token"
    default= "set this"
    sensitive = true
}

variable droplet_size {
    type=string
    default = "s-1vcpu-2gb"
}

variable droplet_image {
    type = string
    default = "ubuntu-24-10-x64"
}

variable droplet_region {
    type = string
    default = "sgp1"
}

variable public_key_name {
    type = string
    description = "public_key_name"
    default= "infra_course"
    sensitive = true
}

variable private_key {
    type = string
    description = "private_key"
}

variable private_key_name {
    type = string
    description = "private_key_name"
    default= "infra_course"
    sensitive = true
}

variable "instance_count" {
    type = number
    default = 1
}

variable "droplets" {
    type = map (
        object({
            size = string
            image = string
            region = string
        }
        )
    )

    default = {
        myserver-512mb = {
            size = "s-1vcpu-512mb-10gb"
            image = "ubuntu-22-04-x64"
            region = "sgp1"
        },
        myserver-1gb = {
            size = "s-1vcpu-1gb"
            image = "ubuntu-24-10-x64"
            region = "sgp1"
        }
    }
}

variable "code_server_password" {
    type = string
    description = "code_server_password"
    sensitive = true
}