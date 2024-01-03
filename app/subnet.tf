locals {
  app_subnet_newbits = 0
  app_subnet_netnum  = 0
}

resource "azurerm_subnet" "service" {
  resource_group_name  = azurerm_virtual_network.service.resource_group_name
  virtual_network_name = azurerm_virtual_network.service.name
  name                 = "services"

  address_prefixes = azurerm_virtual_network.service.address_space

  service_endpoints = [
    "Microsoft.Sql",
  ]

  delegation {
    name = "Microsoft.Web.serverFarms"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

output "app_subnet_address_prefixes" {
  value = azurerm_subnet.service.address_prefixes
}
