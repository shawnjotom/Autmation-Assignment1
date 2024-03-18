resource "azurerm_resource_group" "n01663926_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "n01663926-VNET" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Shown.JoTom"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }

}

resource "azurerm_subnet" "n01663926-SUBNET" {
  name                 = var.subnet_name
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.n01663926-VNET.name
  address_prefixes     = ["10.0.1.0/24"]

  
}

resource "azurerm_network_security_group" "n01663926-NSG" {
  name                = var.nsg_name
  location = var.location
  resource_group_name = var.resource_group_name

  

  security_rule {
    name                        = "rule-ssh"
    priority                    = 1001
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"

  }

  security_rule {
    name                        = "rule-rdp"
    priority                    = 1002
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "3389"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"

  }

  security_rule {
    name                        = "rule-winrm"
    priority                    = 1003
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "5985"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"

  }

  security_rule {
    name                        = "rule-http"
    priority                    = 1004
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"

  }

  tags = {
      Assignment     = "CCGC 5502 Automation Assignment"
      Name           = "Shown.JoTom"
      ExpirationDate = "2024-12-31"
      Environment    = "Learning"
    }
}

resource "azurerm_subnet_network_security_group_association" "n01663926-NSG-Association" {
  subnet_id                 = azurerm_subnet.n01663926-SUBNET.id
  network_security_group_id = azurerm_network_security_group.n01663926-NSG.id
}

