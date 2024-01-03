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

  # FIXME Only need around 8 - 16 IPs
  # Or better yet, just like we did with the hub gateway subnet address prefix,
  # pass it in as a variable
  address_prefixes = var.power_bi_data_gateway_subnet_address_prefixes
}
