locals {
  power_bi_data_gateway_subnet_address_prefixes = cidrsubnet(one(azurerm_virtual_network.main.address_space), 0, 0)
}

resource "azurerm_subnet" "power_bi_data_gateway" {
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name

  name = "PowerBIDataGateway"

  delegation {
    name = "power_bi_data_gateway"
    service_delegation {
      name    = "Microsoft.PowerPlatform/vnetaccesslinks"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }

  address_prefixes = [local.power_bi_data_gateway_subnet_address_prefixes]
}

output "power_bi_data_gateway_subnet_address_prefixes" {
  value = azurerm_subnet.power_bi_data_gateway.address_prefixes
}
