variable "vnet_address_space" {
  type = string
}

resource "azurerm_virtual_network" "main" {
  resource_group_name = azurerm_resource_group.images.name
  location            = azurerm_resource_group.images.location
  name                = "${var.resource_name_prefix}-image-vnet"
  tags                = merge(var.tags, {})

  address_space = [var.vnet_address_space]
}
