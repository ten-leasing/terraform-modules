variable "managed_instance_vnet_resource_group_name" {
  type = string
}

variable "managed_instance_vnet_name" {
  type = string
}

data "azurerm_virtual_network" "managed_instance" {
  resource_group_name = var.managed_instance_vnet_resource_group_name
  name                = var.managed_instance_vnet_name
}
