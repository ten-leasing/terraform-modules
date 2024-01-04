variable "vnet_address_space" {
  type = string
}

resource "azurerm_virtual_network" "main" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "${var.resource_name_prefix}-image-vnet"
  tags                = merge(var.tags, {})

  address_space = [var.vnet_address_space]
}

output "vnet_resource_group_name" {
  value = azurerm_virtual_network.main.resource_group_name
}

output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "vnet_name" {
  value = azurerm_virtual_network.main.name
}

output "vnet_address_space" {
  value = azurerm_virtual_network.main.address_space
}
