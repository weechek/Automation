data "digitalocean_ssh_key" "infra_course" {
  name = var.public_key_name
}

data digitalocean_image code_server_image {
  name = "mysnapshot"
}

resource "digitalocean_droplet" "droplet_day01" {
  name  = "droplet-day01"
  image = data.digitalocean_image.code_server_image.id
  region   = var.droplet_region
  size     = var.droplet_size
  ssh_keys = [data.digitalocean_ssh_key.infra_course.id]

  connection {
    type = "ssh"
    user = "root"
    private_key = file(var.private_key)
    host = self.ipv4_address
    
  }

  provisioner remote-exec {
     inline = [
       "sed -i 's/__REPLACE__/${var.code_server_password}/' /etc/systemd/system/code-server.service",
       "sed -i 's/__REPLACE__/code-server.${self.ipv4_address}.nip.io/' /etc/nginx/sites-available/code-server.conf",
       "systemctl daemon-reload",
       "systemctl restart code-server.service",
       "systemctl restart nginx"
     ] 
   }
}

resource local_file root_at_ip {
   filename = "root@${digitalocean_droplet.droplet_day01.ipv4_address}"
   content = ""
   file_permission = "0444"
}

output codeserver_ipv4 {
   value = digitalocean_droplet.droplet_day01.ipv4_address
}

output code_server_domain {
   value = "code-server.${digitalocean_droplet.droplet_day01.ipv4_address}.nip.io"
}