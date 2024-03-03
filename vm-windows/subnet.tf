variable "virtual_network_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

resource "azurerm_network_security_group" "vm" {
  provider            = azurerm.current
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "${var.resource_name_prefix}-sg"
  tags                = merge(var.tags, {})
}

resource "azurerm_subnet_network_security_group_association" "vm" {
  provider                  = azurerm.current
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.vm.id
}
