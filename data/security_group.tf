resource "azurerm_network_security_group" "managed_instance" {
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = merge(var.tags, {})
  name                = "${var.resource_name_prefix}-mi-sg"
}

resource "azurerm_subnet_network_security_group_association" "managed_instance" {
  network_security_group_id = azurerm_network_security_group.managed_instance.id
  subnet_id                 = azurerm_subnet.managed_instance.id
}

resource "azurerm_network_security_rule" "allow_public_access_in" {
  count                       = var.expose_to_public ? 1 : 0
  resource_group_name         = azurerm_subnet.managed_instance.resource_group_name
  network_security_group_name = azurerm_network_security_group.managed_instance.name

  name   = "public_access"
  access = "Allow"

  description = "Expose to public"
  direction   = "Inbound"
  priority    = 110
  protocol    = "*"

  source_address_prefix      = "*"
  source_port_range          = "*"
  destination_address_prefix = "*"
  destination_port_range     = "3342"
}
