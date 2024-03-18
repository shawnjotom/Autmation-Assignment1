resource "azurerm_availability_set" "linux_availability_set" {
  name                = "linux-availability-set"
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Shown.JoTom"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_storage_account" "vm_bootdiag" {
  name                     = "tfstaten01663926sa"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each            = toset(var.vm_names)
  name                = each.key
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_DS1_v2"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.linux_nic[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  availability_set_id = azurerm_availability_set.linux_availability_set.id

  boot_diagnostics {
    storage_account_uri = "https://tfstaten01663926sa.blob.core.windows.net/tfstatefiles/tfstate"
  }

  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Shown.JoTom"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_virtual_machine_extension" "network_watcher" {
  for_each            = toset(var.vm_names)
  name                = "NetworkWatcherAgentLinux"
  virtual_machine_id  = azurerm_linux_virtual_machine.linux_vm[each.key].id
  publisher           = "Microsoft.Azure.NetworkWatcher"
  type                = "NetworkWatcherAgentLinux"
  type_handler_version = "1.0"

  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Shown.JoTom"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_virtual_machine_extension" "azure_monitor" {
  for_each            = toset(var.vm_names)
  name                = "AzureMonitorLinuxAgent"
  virtual_machine_id  = azurerm_linux_virtual_machine.linux_vm[each.key].id
  publisher           = "Microsoft.Azure.Monitor"
  type                = "AzureMonitorLinuxAgent"
  type_handler_version = "1.0"

  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Shown.JoTom"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_network_interface" "linux_nic" {
  for_each            = toset(var.vm_names)
  name                = "${each.key}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "${each.key}-ipconfig"
    subnet_id                     = azurerm_subnet.linux_subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Shown.JoTom"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_public_ip" "linux_public_ip" {
  for_each            = toset(var.vm_names)
  name                = "${each.key}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.public_ip_allocation_method

  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Shown.JoTom"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_subnet" "linux_subnet" {
  name                 = "linux-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = "n01663926-VNET"
  address_prefixes     = ["10.0.2.0/24"]

}

resource "azurerm_dns_zone" "linux_dns_zone" {
  name                = "linux_dns_zone"
  resource_group_name = var.resource_group_name
}