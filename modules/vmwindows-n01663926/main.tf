resource "azurerm_availability_set" "windows_availability_set" {
  name                = var.availability_set_name
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_storage_account" "vm_bootdiag" {
  name                     = "tfstaten01663926sa"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  count               = 1
  name                = var.windows_vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.windows_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  availability_set_id = azurerm_availability_set.windows_availability_set.id

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  boot_diagnostics {
  storage_account_uri = azurerm_storage_account.vm_bootdiag.primary_blob_endpoint
  }

  network_interface_ids = [
    azurerm_network_interface.windows_nic[0].id,
  ]

  computer_name = "${var.windows_vm_name}-${count.index}"

}

resource "azurerm_virtual_machine_extension" "antimalware_extension" {
  count                 = 1
  virtual_machine_id    = azurerm_windows_virtual_machine.windows_vm[0].id
  name                  = "IaaSAntimalware"
  publisher             = "Microsoft.Compute"
  type                  = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
        "script": "./install_antimalware.ps1"
    }
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
        "script": "./install_antimalware.ps1"
    }
PROTECTED_SETTINGS
}

resource "azurerm_network_interface" "windows_nic" {
  count               = 1
  name                = "${var.windows_vm_name}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "${var.windows_vm_name}-ipconfig"
    subnet_id                     = azurerm_subnet.windows_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_subnet" "windows_subnet" {
  name                 = "windows-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = "n01663926-VNET"
  address_prefixes     = ["10.0.4.0/24"]
}

resource "azurerm_public_ip" "windows_public_ip" {
  count               = 1
  name                = "${var.windows_vm_name}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.public_ip_allocation_method
}

