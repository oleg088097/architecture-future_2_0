terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_compute_instance" "testvm" {
  name = "${var.environment}-vm"
  platform_id = var.platform_id
  zone = var.zone

  resources {
    cores  = var.cores                            # Количество ядер процессора
    memory = var.memory                         # Объём оперативной памяти (Gb)
  }

  boot_disk {
    disk_id = yandex_compute_disk.testvm_disk.id
  }

  network_interface {
    subnet_id = var.subnet_id
  }

  metadata = {
    ssh-keys = var.ssh_keys
  }
}

resource "yandex_compute_disk" "testvm_disk" {
  name      = "${var.environment}-vm-disk"
  type      = "network-ssd"
  zone      = var.zone
  image_id  = var.disk_image_id
  size      = var.disk_size
}