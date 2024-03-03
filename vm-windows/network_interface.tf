resource "azurerm_network_interface" "vm" {
  provider            = azurerm.current
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "${var.resource_name_prefix}-nic"
  tags                = merge(var.tags, {})

  ip_configuration {
    name                          = "${var.resource_name_prefix}-ip_config"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_id
  }
}
