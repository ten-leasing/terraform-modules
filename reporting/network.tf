variable "vnet_address_space" {
  type = list(string)
}

variable "power_bi_data_gateway_subnet_address_prefixes" {
  type = list(string)
}

resource "azurerm_virtual_network" "main" {
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = merge(var.tags, {})

  name = "${var.resource_name_prefix}-reporting-vnet"

  address_space = var.vnet_address_space
}

output "vnet_resource_group_name" {
  value = azurerm_virtual_network.main.resource_group_name
}

output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "vnet_name" {
  value = azurerm_virtual_network.main.name
}

output "vnet_address_space" {
  value = azurerm_virtual_network.main.address_space
}

resource "azurerm_subnet" "power_bi_data_gateway" {
  resource_group_name  = azurerm_virtual_network.main.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name

  name = "PowerBIDataGateway"

  delegation {
    name = "power_bi_data_gateway"
    service_delegation {
      name    = "Microsoft.PowerPlatform/vnetaccesslinks"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }

  address_prefixes = var.power_bi_data_gateway_subnet_address_prefixes
}

output "power_bi_data_gateway_subnet_address_prefixes" {
  value = azurerm_subnet.power_bi_data_gateway.address_prefixes
}
