module "rgroup-n01663926" {
  source                  = "./modules/rgroup-n01663926"
  resource_group_name     = "n01663926-RG" 
  location                = "CanadaCentral"
}

module "network" {
  source                  = "./modules/network-n01663926"
  resource_group_name     = module.rgroup-n01663926.resource_group_name
  location                = module.rgroup-n01663926.resource_group_location
  virtual_network_name    = "n01663926-VNET"
}

module "common" {
  source                  = "./modules/common-n01663926"
  resource_group_name     = module.rgroup-n01663926.resource_group_name
  location                = module.rgroup-n01663926.resource_group_location
}

module "vmlinux" {
  source                  = "./modules/vmlinux-n01663926"
  resource_group_name     = module.rgroup-n01663926.resource_group_name
  location                = module.rgroup-n01663926.resource_group_location
}

module "vmwindows" {
  source                  = "./modules/vmwindows-n01663926"
  resource_group_name     = module.rgroup-n01663926.resource_group_name
  location                = module.rgroup-n01663926.resource_group_location
}

module "datadisk" {
  source              = "./modules/datadisk-n01663926"
  resource_group_name     = module.rgroup-n01663926.resource_group_name
  location                = module.rgroup-n01663926.resource_group_location
  vm_names = [
    "/subscriptions/b5cae5be-e849-4a93-beee-11f4e4f25673/resourceGroups/n01663926-RG/providers/Microsoft.Compute/virtualMachines/vm-linux-01",
    "/subscriptions/b5cae5be-e849-4a93-beee-11f4e4f25673/resourceGroups/n01663926-RG/providers/Microsoft.Compute/virtualMachines/vm-linux-02",
    "/subscriptions/b5cae5be-e849-4a93-beee-11f4e4f25673/resourceGroups/n01663926-RG/providers/Microsoft.Compute/virtualMachines/vm-linux-03",
    "/subscriptions/b5cae5be-e849-4a93-beee-11f4e4f25673/resourceGroups/n01663926-RG/providers/Microsoft.Compute/virtualMachines/vm-linux-04"
  ]

  disk_size_gb        = 10
}

module "loadbalancer" {
  source                  = "./modules/loadbalancer-n01663926"
  resource_group_name     = module.rgroup-n01663926.resource_group_name
  location                = module.rgroup-n01663926.resource_group_location
  lb_name                 = "my-loadbalancer"
  frontend_ip_configuration_name = "frontend-ipconfig"
  backend_pool_name       = "backend-pool"
  probe_name              = "health-probe"
  inbound_nat_rule_name   = "inbound-nat-rule"
  vm_names                = ["vm1", "vm2", "vm3"]
  network_interface_id    = [
    "/subscriptions/b5cae5be-e849-4a93-beee-11f4e4f25673/resourceGroups/n01663926-RG/providers/Microsoft.Compute/virtualMachines/vm-linux-01",
    "/subscriptions/b5cae5be-e849-4a93-beee-11f4e4f25673/resourceGroups/n01663926-RG/providers/Microsoft.Compute/virtualMachines/vm-linux-02",
    "/subscriptions/b5cae5be-e849-4a93-beee-11f4e4f25673/resourceGroups/n01663926-RG/providers/Microsoft.Compute/virtualMachines/vm-linux-03",
    "/subscriptions/b5cae5be-e849-4a93-beee-11f4e4f25673/resourceGroups/n01663926-RG/providers/Microsoft.Compute/virtualMachines/vm-linux-04"
  ]
  subnet_id              = "/subscriptions/b5cae5be-e849-4a93-beee-11f4e4f25673/resourceGroups/n01663926-RG/providers/Microsoft.Network/virtualNetworks/n01663926-VNET/subnets/n01663926-SUBNET"
}

module "postgresql_server" {
  source  = "./modules/database-n01663926"
  
  name           = "pg-server" 
  resource_group_name     = module.rgroup-n01663926.resource_group_name
  location                = module.rgroup-n01663926.resource_group_location
  admin_username                   = "myadminuser"
  admin_password                   = "P@ssw0rd"
  sku_name                         = "B_Gen5_1"
  postgresql_version               = "11"
  storage_mb                       = 640000
  backup_retention_days            = 7
  geo_redundant_backup_enabled     = false
  auto_grow_enabled                = true
  public_network_access_enabled    = false
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
  
}

