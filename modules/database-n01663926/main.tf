resource "azurerm_postgresql_server" "database_instance" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  administrator_login = var.admin_username
  administrator_login_password = var.admin_password
  sku_name            = var.sku_name
  version             = var.postgresql_version
  storage_mb = var.storage_mb

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  auto_grow_enabled            = var.auto_grow_enabled

  public_network_access_enabled    = var.public_network_access_enabled
  ssl_enforcement_enabled          = var.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = var.ssl_minimal_tls_version_enforced

}


