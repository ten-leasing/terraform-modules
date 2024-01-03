locals {
  packer_subnet_address_prefixes = cidrsubnet(one(azurerm_virtual_network.main.address_space), 0, 0)
}

resource "azurerm_subnet" "packer" {
  resource_group_name  = azurerm_virtual_network.main.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name

  address_prefixes = local.packer_subnet_address_prefixes
  name             = "packer"
}
