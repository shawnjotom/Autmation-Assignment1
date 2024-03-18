resource "null_resource" "display_info" {
  for_each = toset(var.vm_names)

  triggers = {
    vm_id = azurerm_linux_virtual_machine.linux_vm[each.key].id
  }

  provisioner "remote-exec" {
    inline = [
      "echo Hostname: $(hostname)",
      "echo Domain: $(hostname -d)",
      "echo Private IP: $(hostname -I)",
      "echo Public IP: $(curl -s ifconfig.co)"
    ]

    connection {
      type        = "ssh"
      user        = var.admin_username
      private_key = file(var.private_key_path)
      host        = azurerm_public_ip.linux_public_ip[each.key].ip_address
    }
  }
}
