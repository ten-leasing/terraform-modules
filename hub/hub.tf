locals {
  hub_vnet_reserved_subnet_size = 24
  hub_vnet_subnet_newbits       = local.hub_vnet_reserved_subnet_size - var.global_vnet_address_space
  hub_address_space             = cidrsubnets(var.global_vnet_address_space, local.hub_vnet_subnet_newbits)
}

variable "global_vnet_address_space" {
  type = string
}

resource "azurerm_virtual_network" "hub" {
  resource_group_name = azurerm_resource_group.hub.name
  location            = azurerm_resource_group.hub.location

  name = "${var.resource_name_prefix}-hub-vnet"
  tags = merge(var.tags, {})

  address_space = local.hub_address_space
}

output "hub_resource_group_name" {
  value = azurerm_virtual_network.hub.resource_group_name
}

output "hub_network_id" {
  value = azurerm_virtual_network.hub.id
}

output "hub_network_name" {
  value = azurerm_virtual_network.hub.name
}

output "hub_address_space" {
  value = azurerm_virtual_network.hub.address_space
}
