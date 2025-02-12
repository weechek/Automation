source digitalocean nginx_snapshot {
  api_token = var.DO_token
  image = var.droplet_image
  size = var.droplet_size
  region = var.droplet_region
  snapshot_name = var.snapshot_name
  ssh_username = "root"
}

build {
  sources = [ "source.digitalocean.nginx_snapshot" ]

  provisioner ansible {
    playbook_file = "playbook.yaml"
    extra_arguments = [
      "--extra-vars",
      "code_server_archive=${var.code_server_archive}"
    ]
  }
}