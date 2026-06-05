variable "platform_id" {
  type        = string
  description = "Yandex Cloud platform id"
}

variable "zone" {
  type        = string
  description = "Yandex Cloud zone"
}

variable "cloud_id" {
  type        = string
  description = "Yandex Cloud cloud id"
}

variable "folder_id" {
  type        = string
  description = "Yandex Cloud folder id"
}

variable "cores" {
  type        = number
  description = "CPU count"
}

variable "memory" {
  type        = number
  description = "RAM in GB"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where the web server will be deployed"
}

variable "disk_image_id" {
  type        = string
  description = "Attached Disk image"
}

variable "disk_size" {
  type        = number
  description = "Attached Disk size in GB"
}

variable "environment" {
  type        = string
  description = "Deployment environment name"

  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "Environment must be dev, stage, or prod."
  }
}