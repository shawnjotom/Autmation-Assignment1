output "resource_group_name" {
  value = module.rgroup-n01663926.resource_group_name
}

output "virtual_network_name" {
  value = module.network.virtual_network_name
}

output "subnet_name" {
  value = module.network.subnet_name
}

output "storage_account_name" {
  value = module.common.storage_account_name
}

output "log_analytics_workspace_name" {
  value = module.common.log_analytics_workspace_name
}

output "recovery_services_vault_name" {
  value = module.common.recovery_services_vault_name
}

output "linux_vm_hostnames" {
  value = module.vmlinux.vm_hostnames
}

output "linux_vm_private_ips" {
  value = module.vmlinux.vm_private_ip_addresses
}

output "linux_vm_public_ips" {
  value = module.vmlinux.vm_public_ip_addresses
}

output "windows_vm_hostnames" {
  value = module.vmwindows.windows_vm_hostname
}

output "windows_vm_private_ips" {
  value = module.vmwindows.windows_vm_private_ip
}

output "windows_vm_public_ips" {
  value = module.vmwindows.windows_vm_public_ip
}

output "data_disk_ids" {
  value = module.datadisk.managed_disk_ids
}

output "database_instance_name" {
  value = module.postgresql_server.database_instance_name
}