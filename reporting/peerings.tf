locals {
  reporting_resource_group_name = "DevOps_Reporting_Portal"
  reporting_vnet_name           = "vnet_prod_east_001"
}

data "azurerm_virtual_network" "old_reporting" {
  resource_group_name = local.reporting_resource_group_name
  name                = local.reporting_vnet_name
}

module "vnet_and_old_reporting_peering" {
  source = "git::https://star-leasing@dev.azure.com/star-leasing/Architecture/_git/terraform-library//azure-vnet-peerings?ref=default"

  vnet1_resource_group_name = var.vnet_resource_group_name
  vnet1_name                = var.vnet_name
  vnet1_id                  = var.vnet_id
  vnet1_address_space       = var.vnet_address_space

  vnet2_resource_group_name = data.azurerm_virtual_network.old_reporting.resource_group_name
  vnet2_name                = data.azurerm_virtual_network.old_reporting.name
  vnet2_id                  = data.azurerm_virtual_network.old_reporting.id
  vnet2_address_space       = data.azurerm_virtual_network.old_reporting.address_space
}
