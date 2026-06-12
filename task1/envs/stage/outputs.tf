output "instance_id" {
  description = "ID of the VM instance"
  value       = module.vm.instance_id
}

output "instance_ip" {
  description = "Private IP address of the VM instance"
  value       = module.vm.instance_ip
}

output "instance_name" {
  description = "Name of the VM instance"
  value       = module.vm.instance_name
}

output "disk_id" {
  description = "ID of the attached boot disk"
  value       = module.vm.disk_id
}
