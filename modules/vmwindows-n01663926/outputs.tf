output "windows_vm_hostname" {
  description = "Hostname of the Windows VM"
  value = azurerm_windows_virtual_machine.windows_vm[0].computer_name
}

output "windows_vm_private_ip" {
  description = "Private IP address of the Windows VM"
  value       = azurerm_network_interface.windows_nic[0].private_ip_address
}

output "windows_vm_public_ip" {
  description = "Public IP address of the Windows VM"
  value       = azurerm_public_ip.windows_public_ip[0].ip_address
}


