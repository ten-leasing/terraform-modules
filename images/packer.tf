locals {
  packer_vnet_address_space = [cidrsubnet(var.global_vnet_address_space, 8, var.packer_vnet_id)]
}

variable "packer_vnet_id" {
  type    = number
  default = 6
}

variable "global_vnet_address_space" {
  type = string
}

data "azurerm_client_config" "current" {}

data "azurerm_virtual_network" "hub" {
  resource_group_name = "${var.resource_name_prefix}-hub"
  name                = "${var.resource_name_prefix}-hub-vnet"
}

resource "azurerm_key_vault" "packer" {
  tenant_id           = data.azurerm_client_config.current.tenant_id
  resource_group_name = azurerm_resource_group.images.name
  location            = azurerm_resource_group.images.location
  tags                = merge(var.tags, {})

  name                          = "${var.resource_name_prefix}-kv"
  sku_name                      = "standard"
  purge_protection_enabled      = false
  public_network_access_enabled = true

  enabled_for_deployment    = true
  enable_rbac_authorization = true

  # network_acls {
  #   ip_rules = [ "value" ]
  # }
}

resource "azurerm_virtual_network" "packer" {
  resource_group_name = azurerm_resource_group.images.name
  location            = azurerm_resource_group.images.location
  tags                = merge(var.tags, {})

  address_space = local.packer_vnet_address_space
  name          = "${var.resource_name_prefix}-packer-vnet"
}

module "hub_and_packer_peering" {
  source = "git::https://star-leasing@dev.azure.com/star-leasing/Architecture/_git/terraform-library//azure-vnet-peerings?ref=default"

  vnet1_resource_group_name = data.azurerm_virtual_network.hub.resource_group_name
  vnet1_name                = data.azurerm_virtual_network.hub.name
  vnet1_id                  = data.azurerm_virtual_network.hub.id
  vnet1_address_space       = data.azurerm_virtual_network.hub.address_space

  vnet2_resource_group_name = azurerm_virtual_network.packer.resource_group_name
  vnet2_name                = azurerm_virtual_network.packer.name
  vnet2_id                  = azurerm_virtual_network.packer.id
  vnet2_address_space       = azurerm_virtual_network.packer.address_space
}

resource "azurerm_subnet" "packer" {
  resource_group_name  = azurerm_virtual_network.packer.resource_group_name
  virtual_network_name = azurerm_virtual_network.packer.name

  address_prefixes = azurerm_virtual_network.packer.address_space
  name             = "packer"
}
