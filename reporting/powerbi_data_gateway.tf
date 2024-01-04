locals {
}

resource "azurerm_subnet" "power_bi_data_gateway" {
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name

  name = "PowerBIDataGateway"

  delegation {
    name = "power_bi_data_gateway"
    service_delegation {
      name    = "Microsoft.PowerPlatform/vnetaccesslinks"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }

  address_prefixes = var.subnet_address_prefixes
}

output "power_bi_data_gateway_subnet_address_prefixes" {
  value = azurerm_subnet.power_bi_data_gateway.address_prefixes
}
