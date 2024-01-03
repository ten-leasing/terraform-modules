locals {
  reporting_resource_group_name = "DevOps_Reporting_Portal"
  reporting_vnet_name           = "vnet_prod_east_001"
}

data "azurerm_virtual_network" "reporting" {
  resource_group_name = local.reporting_resource_group_name
  name                = local.reporting_vnet_name
}

module "reporting_and_reporting_peering" {
  source = "git::https://star-leasing@dev.azure.com/star-leasing/Architecture/_git/terraform-library//azure-vnet-peerings?ref=default"

  vnet1_resource_group_name           = azurerm_virtual_network.main.resource_group_name
  vnet1_name                          = azurerm_virtual_network.main.name
  vnet1_id                            = azurerm_virtual_network.main.id
  vnet1_address_space                 = azurerm_virtual_network.main.address_space
  vnet1_allow_vnet2_forwarded_traffic = false
  vnet1_allow_vnet2_gateway_transit   = false

  vnet2_resource_group_name           = data.azurerm_virtual_network.reporting.resource_group_name
  vnet2_name                          = data.azurerm_virtual_network.reporting.name
  vnet2_id                            = data.azurerm_virtual_network.reporting.id
  vnet2_address_space                 = data.azurerm_virtual_network.reporting.address_space
  vnet2_allow_vnet1_forwarded_traffic = false
  vnet2_use_vnet1_remote_gateway      = false
}

module "reporting_and_data_peering" {
  source = "git::https://star-leasing@dev.azure.com/star-leasing/Architecture/_git/terraform-library//azure-vnet-peerings?ref=default"

  vnet1_resource_group_name           = azurerm_virtual_network.main.resource_group_name
  vnet1_name                          = azurerm_virtual_network.main.name
  vnet1_id                            = azurerm_virtual_network.main.id
  vnet1_address_space                 = azurerm_virtual_network.main.address_space
  vnet1_allow_vnet2_forwarded_traffic = false
  vnet1_allow_vnet2_gateway_transit   = false

  vnet2_resource_group_name           = var.managed_instance_vnet_resource_group_name
  vnet2_name                          = var.managed_instance_vnet_name
  vnet2_id                            = var.managed_instance_vnet_id
  vnet2_address_space                 = var.managed_instance_vnet_address_space
  vnet2_allow_vnet1_forwarded_traffic = false
  vnet2_use_vnet1_remote_gateway      = false
}

module "hub_and_old_reporting_peering" {
  source = "git::https://star-leasing@dev.azure.com/star-leasing/Architecture/_git/terraform-library//azure-vnet-peerings?ref=default"

  vnet1_resource_group_name = var.hub_vnet_resource_group_name
  vnet1_name                = var.hub_vnet_name
  vnet1_id                  = var.hub_vnet_id
  vnet1_address_space       = var.hub_vnet_address_space

  vnet2_resource_group_name = data.azurerm_virtual_network.reporting.resource_group_name
  vnet2_name                = data.azurerm_virtual_network.reporting.name
  vnet2_id                  = data.azurerm_virtual_network.reporting.id
  vnet2_address_space       = data.azurerm_virtual_network.reporting.address_space
}

module "old_reporting_and_data_peering" {
  source = "git::https://star-leasing@dev.azure.com/star-leasing/Architecture/_git/terraform-library//azure-vnet-peerings?ref=default"

  vnet1_resource_group_name           = data.azurerm_virtual_network.reporting.resource_group_name
  vnet1_name                          = data.azurerm_virtual_network.reporting.name
  vnet1_id                            = data.azurerm_virtual_network.reporting.id
  vnet1_address_space                 = data.azurerm_virtual_network.reporting.address_space
  vnet1_allow_vnet2_forwarded_traffic = false
  vnet1_allow_vnet2_gateway_transit   = false

  vnet2_resource_group_name           = var.managed_instance_vnet_resource_group_name
  vnet2_name                          = var.managed_instance_vnet_name
  vnet2_id                            = var.managed_instance_vnet_id
  vnet2_address_space                 = var.managed_instance_vnet_address_space
  vnet2_allow_vnet1_forwarded_traffic = false
  vnet2_use_vnet1_remote_gateway      = false
}
