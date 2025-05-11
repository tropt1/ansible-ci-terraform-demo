resource "yandex_vpc_network" "vpc" {
  name = "demo-network"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "demo-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = ["10.10.0.0/24"]
}

resource "yandex_compute_disk" "disk"{
  name     = "demo-sidk"
  zone     = var.zone
  type     = "network-ssd"
  size     = 20
  image_id = data.yandex_compute_image.ubuntu.id
}

data "yandex_compute_instance" "vm" {
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "vm" {
  name = "demo-vm"
  zone = var.zone

  resource_preset_id = "s2.micro" # 1 vCPU, 2 gib RAM

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/yandexCloud_ssh")}"
  }
}
