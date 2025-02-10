data "digitalocean_ssh_key" "infra_course" {
  name = var.public_key_name
}

#resource "digitalocean_droplet" "droplet_day01" {
#  for_each = var.droplets
#  name     = each.key
#  image    = each.value.image
#  region   = each.value.region
#  size     = each.value.size
#  ssh_keys = [data.digitalocean_ssh_key.infra_course.id]
#}

#resource "digitalocean_droplet" "droplet_day01" {
#  count = var.instance_count
#  name     = "droplet-day01-${count.index}"
#  image    = var.droplet_image
#  region   = var.droplet_region
#  size     = var.droplet_size
#  ssh_keys = [data.digitalocean_ssh_key.infra_course.id]
#
#  connection {
#    type = "ssh"
#    user = "fred"
#    private_key = file(var.private_key)
#    host = self.ipv4_address
#    
#  }
#
#  provisioner "remote-exec" {
#    inline = [
#        "apt update"
#    ]
#}
#}

resource "digitalocean_droplet" "droplet_day01" {
  name     = "droplet-day01-01"
  image    = var.droplet_image
  region   = var.droplet_region
  size     = var.droplet_size
  ssh_keys = [data.digitalocean_ssh_key.infra_course.id]

  connection {
    type = "ssh"
    user = "root"
    private_key = file(var.private_key)
    host = self.ipv4_address
    
  }

  provisioner "remote-exec" {
    inline = [
        "apt update",
        "apt upgrade -y",
        "apt install nginx -y",
        "systemctl enable nginx",
        "systemctl start nginx"
    ]
}

  provisioner "file" {
    source = "assets/"
    destination = "/var/www/html/"
  }

}

resource "local_file" "index_html" {
    filename = "assets/index.html"
    file_permission = "0644"
    content = templatefile("assets/index.html.tftpl",{
        droplet_ip = digitalocean_droplet.droplet_day01.ipv4_address
    })
}

resource "local_file" "nginx_dns" {
    filename = "nginx-${digitalocean_droplet.droplet_day01.ipv4_address}.ntp.io"
    content = ""
    file_permission = "0444"
}

output "infra_course_fingerprint" {
    value = data.digitalocean_ssh_key.infra_course.fingerprint
}

output "infra_course_certificate_public_key" {
    value = data.digitalocean_ssh_key.infra_course.public_key
}

output "droplet_day01_ipv4_addr" {

    value = digitalocean_droplet.droplet_day01.ipv4_address
}