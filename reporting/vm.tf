locals {
}

resource "azurerm_subnet" "reporting" {
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name

  name = "reporting"

  address_prefixes = var.subnet_address_prefixes
}
