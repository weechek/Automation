variable DO_token {
 type = string
 sensitive = true
 default = "set this"
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

variable snapshot_name {
    type = string
    default = "mysnapshot"
}

variable code_server_archive {
    type = string
    default = "https://github.com/coder/code-server/releases/download/v4.96.4/code-server-4.96.4-linux-amd64.tar.gz"
}

variable public_key_name {
    type = string
    description = "public_key_name"
    default= "infra_course"
    sensitive = true
}