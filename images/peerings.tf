module "hub_and_packer_peering" {
  source = "git::https://star-leasing@dev.azure.com/star-leasing/Architecture/_git/terraform-library//azure-vnet-peerings?ref=default"

  vnet1_resource_group_name = var.hub_vnet_resource_group_name
  vnet1_name                = var.hub_vnet_name
  vnet1_id                  = var.hub_vnet_id
  vnet1_address_space       = var.hub_vnet_address_space

  vnet2_resource_group_name = azurerm_virtual_network.main.resource_group_name
  vnet2_name                = azurerm_virtual_network.main.name
  vnet2_id                  = azurerm_virtual_network.main.id
  vnet2_address_space       = azurerm_virtual_network.main.address_space
}
