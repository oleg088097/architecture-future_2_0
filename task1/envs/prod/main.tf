terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = "/workspace/authorized_key.json"
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

module "vm" {
  source = "../../modules/vm"

  zone          = var.zone
  platform_id   = var.platform_id
  cores         = var.cores
  memory        = var.memory
  subnet_id     = var.subnet_id
  disk_image_id = var.disk_image_id
  disk_size     = var.disk_size
  ssh_keys      = "ubuntu:${file("./prod.pub")}"
  environment   = var.environment
}