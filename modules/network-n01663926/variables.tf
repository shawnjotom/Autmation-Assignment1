variable "resource_group_name" {
  type        = string
  default = "n01663926-RG"
}

variable "location" {
  type        = string
  default = "CanadaCentral"
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  default     = "n01663926-VNET"
}

variable "subnet_name" {

}

variable "subnet_address_prefix" {
  description = "The address prefix for the subnet"
  default     = "10.0.1.0/24"
}

variable "nsg_name" {

}
