locals {
}

variable "global_vnet_address_space" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "hub_vnet_resource_group_name" {
  type = string
}

variable "hub_vnet_name" {
  type = string
}

variable "hub_vnet_id" {
  type = string
}

variable "hub_vnet_address_space" {
  type = list(string)
}

resource "azurerm_virtual_network" "managed_instance" {
  resource_group_name = azurerm_user_assigned_identity.managed_instance.resource_group_name
  location            = azurerm_user_assigned_identity.managed_instance.location
  tags                = merge(var.tags, {})

  name          = "${var.resource_name_prefix}-mi-vnet"
  address_space = var.vnet_address_space
}

output "vnet_resource_group_name" {
  value = azurerm_virtual_network.managed_instance.resource_group_name
}

output "vnet_id" {
  value = azurerm_virtual_network.managed_instance.id
}

output "vnet_name" {
  value = azurerm_virtual_network.managed_instance.name
}

output "vnet_address_space" {
  value = azurerm_virtual_network.managed_instance.address_space
}

module "hub_and_data_peering" {
  source = "git::https://star-leasing@dev.azure.com/star-leasing/Architecture/_git/terraform-library//azure-vnet-peerings?ref=default"

  vnet1_resource_group_name = var.hub_vnet_resource_group_name
  vnet1_name                = var.hub_vnet_name
  vnet1_id                  = var.hub_vnet_id
  vnet1_address_space       = var.hub_vnet_address_space

  vnet2_resource_group_name = azurerm_virtual_network.managed_instance.resource_group_name
  vnet2_name                = azurerm_virtual_network.managed_instance.name
  vnet2_id                  = azurerm_virtual_network.managed_instance.id
  vnet2_address_space       = azurerm_virtual_network.managed_instance.address_space
}

resource "azurerm_subnet" "managed_instance" {
  resource_group_name  = azurerm_virtual_network.managed_instance.resource_group_name
  virtual_network_name = azurerm_virtual_network.managed_instance.name
  name                 = "ManagedInstance"
  address_prefixes     = azurerm_virtual_network.managed_instance.address_space

  delegation {
    name = "managed_instance"
    service_delegation {
      name = "Microsoft.Sql/managedInstances"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
    }
  }
}

output "subnet_address_prefixes" {
  value = azurerm_subnet.managed_instance.address_prefixes
}
