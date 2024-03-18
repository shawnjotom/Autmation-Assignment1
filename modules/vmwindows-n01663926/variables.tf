variable "location" {
  type    = string
  default = "CanadaCentral"
}

variable "resource_group_name" {
  type    = string
  default = "n01663926-RG"
}

variable "availability_set_name" {
  default     = "windows-availability-set"
}

variable "windows_vm_name" {
  default     = "win-vm"
}

variable "windows_size" {
  default     = "Standard_DS1_v2"
}

variable "admin_username" {
  default     = "adminuser"
}

variable "admin_password" {
  default     = "Password123!@#"
}

variable "public_ip_allocation_method" {
  default     = "Dynamic"
}

