resource "azurerm_virtual_network" "main" {
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = merge(var.tags, {})

  name = "${var.resource_name_prefix}-reporting-vnet"

  address_space = var.vnet_address_space
}
