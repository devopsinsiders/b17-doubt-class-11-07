variable "resource_group_name" {
  description = "The name of the resource group in which the subnet will be created."
  type        = string  
}

variable "virtual_network_name" {
  description = "The name of the virtual network in which the subnet will be created."
  type        = string  
}

variable "subnet_name" {
  description = "The name of the subnet to be created."
  type        = string    
}

variable "address_prefixes" {
  description = "The address prefixes for the subnet."
  type        = list(string)  
}