locals {
  packer_subnet_address_prefixes = cidrsubnet(one(var.vnet_address_space), 0, 0)
}

resource "azurerm_subnet" "packer" {
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name

  address_prefixes = [local.packer_subnet_address_prefixes]
  name             = "packer"
}
