locals {
  app_vnet_address_space = [cidrsubnet(var.global_vnet_address_space, 8, random_integer.random_vnet_id.result)]
}

variable "global_vnet_address_space" {
  type = string
}

resource "random_integer" "random_vnet_id" {
  min = 100
  max = 199
}

resource "azurerm_virtual_network" "service" {
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tags                = merge(var.tags, {})
  name                = "${var.resource_name_prefix}-service-vnet"

  address_space = local.app_vnet_address_space
}

output "app_vnet_address_space" {
  value = azurerm_virtual_network.service.address_space
}

module "service_and_data_peering" {
  source = "git::https://star-leasing@dev.azure.com/star-leasing/Architecture/_git/terraform-library//azure-vnet-peerings?ref=default"

  vnet1_resource_group_name           = azurerm_virtual_network.service.resource_group_name
  vnet1_name                          = azurerm_virtual_network.service.name
  vnet1_id                            = azurerm_virtual_network.service.id
  vnet1_address_space                 = azurerm_virtual_network.service.address_space
  vnet1_allow_vnet2_gateway_transit   = false
  vnet1_allow_vnet2_forwarded_traffic = false
  vnet1_use_vnet2_remote_gateway      = false

  vnet2_resource_group_name           = data.azurerm_virtual_network.managed_instance.resource_group_name
  vnet2_name                          = data.azurerm_virtual_network.managed_instance.name
  vnet2_id                            = data.azurerm_virtual_network.managed_instance.id
  vnet2_address_space                 = data.azurerm_virtual_network.managed_instance.address_space
  vnet2_allow_vnet1_gateway_transit   = false
  vnet2_allow_vnet1_forwarded_traffic = false
  vnet2_use_vnet1_remote_gateway      = false
}
