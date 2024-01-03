locals {
}

resource "azurerm_route_table" "managed_instance" {
  resource_group_name = azurerm_resource_group.data.name
  location            = azurerm_resource_group.data.location
  tags                = merge(var.tags, {})

  name = "${var.resource_name_prefix}-mi-rt"

  # route = local.routes
}

resource "azurerm_subnet_route_table_association" "managed_instance" {
  route_table_id = azurerm_route_table.managed_instance.id
  subnet_id      = azurerm_subnet.managed_instance.id
}
