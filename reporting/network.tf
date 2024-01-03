variable "vnet_address_space" {
  type = list(string)
}

resource "azurerm_virtual_network" "main" {
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = merge(var.tags, {})

  name = "${var.resource_name_prefix}-reporting-vnet"

  address_space = var.vnet_address_space
}

resource "azurerm_subnet" "power_bi_data_gateway" {
  resource_group_name  = azurerm_virtual_network.power_bi.resource_group_name
  virtual_network_name = azurerm_virtual_network.power_bi.name

  name = "PowerBIDataGateway"

  delegation {
    name = "power_bi_data_gateway"
    service_delegation {
      name    = "Microsoft.PowerPlatform/vnetaccesslinks"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }

  address_prefixes = [cidrsubnet(azurerm_virtual_network.power_bi.address_space[0], 4, 0)]
}
