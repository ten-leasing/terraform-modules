data "azurerm_virtual_network" "managed_instance" {
  resource_group_name = "${var.resource_name_prefix}-data"
  name                = "${var.resource_name_prefix}-mi-vnet"
}
