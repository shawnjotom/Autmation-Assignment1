resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "n01663926-law"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = {
    Assignment      = "CCGC 5502 Automation Assignment"
    Name            = "Shown.JoTom"
    ExpirationDate  = "2024-12-31"
    Environment     = "Learning"
  }
}

resource "azurerm_recovery_services_vault" "recovery_services_vault" {
  name                = "n01663926-rsv"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  tags = {
    Assignment      = "CCGC 5502 Automation Assignment"
    Name            = "Shown.JoTom"
    ExpirationDate  = "2024-12-31"
    Environment     = "Learning"
  }
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "n01663926sa"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Assignment      = "CCGC 5502 Automation Assignment"
    Name            = "Shown.JoTom"
    ExpirationDate  = "2024-12-31"
    Environment     = "Learning"
  }
}

