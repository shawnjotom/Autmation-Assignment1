variable "location" {

}

variable "resource_group_name" {

}

variable "admin_username" {
   
}

variable "admin_password" {
  description = "The administrator password for the PostgreSQL server."
  default     = "P@ssw0rd" 
sensitive = true
}

variable "name" {
 
}

variable "sku_name" {

}

variable "postgresql_version" {
      
}

variable "ssl_enforcement_enabled" {
}

variable "ssl_minimal_tls_version_enforced" {
}

variable "storage_mb"{
 
}

variable public_network_access_enabled {

}


variable backup_retention_days {

}



variable geo_redundant_backup_enabled  {

}

variable auto_grow_enabled  {

}