variable "location" {
  type    = string
  default = "CanadaCentral"
}

variable "resource_group_name" {
  type    = string
  default = "n01663926-RG"
}

variable "vm-linux-0_names" {
  type        = list(string)
  description = "List of vm-linux-0 names to attach data disks"
  default     = ["vm-linux-01", "vm-linux-02", "vm-linux-03", "vm-linux-04"] 
}

variable "disk_size_gb" {
  type        = number
  description = "Size of each data disk in GB"
  default     = 10
}

variable "vm_ids" {
  description = "List of virtual machine IDs"
  type        = list(string)
  default     = [
    "/subscriptions/b5cae5be-e849-4a93-beee-11f4e4f25673/resourceGroups/n01663926-RG/providers/Microsoft.Compute/virtualMachines/vm-linux-01",
    "/subscriptions/b5cae5be-e849-4a93-beee-11f4e4f25673/resourceGroups/n01663926-RG/providers/Microsoft.Compute/virtualMachines/vm-linux-02",
    "/subscriptions/b5cae5be-e849-4a93-beee-11f4e4f25673/resourceGroups/n01663926-RG/providers/Microsoft.Compute/virtualMachines/vm-linux-03",
    "/subscriptions/b5cae5be-e849-4a93-beee-11f4e4f25673/resourceGroups/n01663926-RG/providers/Microsoft.Compute/virtualMachines/vm-linux-04"
  ]
}

variable "vm_names" {
  type        = list(string)
   default     = ["vm-linux-01", "vm-linux-02", "vm-linux-03", "vm-linux-04"]
}

