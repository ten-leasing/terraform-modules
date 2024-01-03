locals {
  reporting_on_prem_address_space = ["10.135.159.0/24", "192.168.10.0/24"]
  reporting_vnet_name             = "vnet_prod_east_001"
  reporting_resource_group_name   = "DevOps_Reporting_Portal"
}

variable "hub_vnet_resource_group_name" {
  type = string
}

variable "hub_vnet_virtual_network_name" {
  type = string
}

data "azurerm_virtual_network" "reporting" {
  resource_group_name = local.reporting_resource_group_name
  name                = local.reporting_vnet_name
}

data "azurerm_virtual_network" "hub" {
  resource_group_name = var.hub_vnet_resource_group_name
  name                = var.hub_vnet_virtual_network_name
}

module "hub_and_reporting_peering" {
  source = "git::https://star-leasing@dev.azure.com/star-leasing/Architecture/_git/terraform-library//azure-vnet-peerings?ref=default"

  vnet1_resource_group_name = data.azurerm_virtual_network.hub.resource_group_name
  vnet1_name                = data.azurerm_virtual_network.hub.name
  vnet1_id                  = data.azurerm_virtual_network.hub.id
  vnet1_address_space       = data.azurerm_virtual_network.hub.address_space

  vnet2_resource_group_name = data.azurerm_virtual_network.reporting.resource_group_name
  vnet2_name                = data.azurerm_virtual_network.reporting.name
  vnet2_id                  = data.azurerm_virtual_network.reporting.id
  vnet2_address_space       = data.azurerm_virtual_network.reporting.address_space
}

module "reporting_and_data_peering" {
  source = "git::https://star-leasing@dev.azure.com/star-leasing/Architecture/_git/terraform-library//azure-vnet-peerings?ref=default"

  vnet1_resource_group_name           = data.azurerm_virtual_network.reporting.resource_group_name
  vnet1_name                          = data.azurerm_virtual_network.reporting.name
  vnet1_id                            = data.azurerm_virtual_network.reporting.id
  vnet1_address_space                 = data.azurerm_virtual_network.reporting.address_space
  vnet1_allow_vnet2_forwarded_traffic = false
  vnet1_allow_vnet2_gateway_transit   = false

  vnet2_resource_group_name           = data.azurerm_virtual_network.managed_instance.resource_group_name
  vnet2_name                          = data.azurerm_virtual_network.managed_instance.name
  vnet2_id                            = data.azurerm_virtual_network.managed_instance.id
  vnet2_address_space                 = data.azurerm_virtual_network.managed_instance.address_space
  vnet2_allow_vnet1_forwarded_traffic = false
  vnet2_use_vnet1_remote_gateway      = false
}
