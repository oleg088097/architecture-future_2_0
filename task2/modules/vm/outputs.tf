output "instance_id" {
  description = "ID of the VM instance"
  value       = yandex_compute_instance.testvm.id
}

output "instance_ip" {
  description = "Private IP address of the VM instance"
  value       = yandex_compute_instance.testvm.network_interface[0].ip_address
}

output "instance_name" {
  description = "Name of the VM instance"
  value       = yandex_compute_instance.testvm.name
}

output "disk_id" {
  description = "ID of the attached boot disk"
  value       = yandex_compute_instance.testvm.boot_disk[0].disk_id
}