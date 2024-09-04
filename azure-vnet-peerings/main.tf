terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      configuration_aliases = [azurerm.vnet1_provider, azurerm.vnet2_provider]
    }
  }
}

resource "azurerm_virtual_network_peering" "vnet1_to_vnet2" {
  provider            = azurerm.vnet1_provider
  resource_group_name = var.vnet1_resource_group_name

  name                      = "to_${var.vnet2_name}"
  virtual_network_name      = var.vnet1_name
  remote_virtual_network_id = var.vnet2_id

  allow_virtual_network_access = var.vnet1_allow_vnet2_network_access
  allow_gateway_transit        = var.vnet1_allow_vnet2_gateway_transit
  allow_forwarded_traffic      = var.vnet1_allow_vnet2_forwarded_traffic
  use_remote_gateways          = var.vnet1_use_vnet2_remote_gateway

  triggers = {
    remote_address_space = join(",", var.vnet2_address_space)
  }
}

resource "azurerm_virtual_network_peering" "vnet2_to_vnet1" {
  provider            = azurerm.vnet2_provider
  resource_group_name = var.vnet2_resource_group_name

  name                      = "to_${var.vnet1_name}"
  virtual_network_name      = var.vnet2_name
  remote_virtual_network_id = var.vnet1_id

  allow_virtual_network_access = var.vnet2_allow_vnet1_network_access
  allow_gateway_transit        = var.vnet2_allow_vnet1_gateway_transit
  allow_forwarded_traffic      = var.vnet2_allow_vnet1_forwarded_traffic
  use_remote_gateways          = var.vnet2_use_vnet1_remote_gateway

  triggers = {
    remote_address_space = join(",", var.vnet1_address_space)
  }
}
