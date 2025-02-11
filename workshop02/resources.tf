data "digitalocean_ssh_key" "infra_course" {
  name = var.public_key_name
}

resource "digitalocean_droplet" "droplet_day01" {
  name     = "droplet-day01-01"
  image    = var.droplet_image
  region   = var.droplet_region
  size     = var.droplet_size
  ssh_keys = [data.digitalocean_ssh_key.infra_course.id]

}

resource "local_file" "inventories_yaml"{
  filename = "inventories.yaml"
  content = templatefile("inventories.yaml.tftpl", {
    private_key_path = var.private_key
    droplet_ip = digitalocean_droplet.droplet_day01.ipv4_address
  })
  file_permission = 0444
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