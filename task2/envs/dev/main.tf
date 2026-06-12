terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    bucket      = "future20"
    key         = "dev/terraform.json"
    region      = "ru-central1"
    endpoints   = {
        s3 = "https://storage.yandexcloud.net/"
    }
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
 }
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
  ssh_keys      = "ubuntu:${file("./dev.pub")}"
  environment   = var.environment
}