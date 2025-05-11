data "yandex_resourcemanager_folder" "terraform-demo" {
  folder_id = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = "${data.yandex_resourcemanager_folder.terraform-demo.id}"
  role      = "admin"
  member   = "serviceAccount:ajej3140ejplajbf8db1"
}

resource "yandex_vpc_network" "vpc" {
  name = "demo-vpc"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "demo-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = ["10.10.0.0/24"]
}
data "yandex_compute_image" "ubuntu"{
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "vm" {
  name = "demo-vm"
  zone = var.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      type     = "network-hdd"
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/yandexCloud_ssh.pub")}"
  }
}
