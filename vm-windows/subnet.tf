variable "virtual_network_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "subnet_address_prefixes" {
  type = list(string)
}

resource "azurerm_subnet" "vm" {
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name

  address_prefixes = var.subnet_address_prefixes
  name             = var.subnet_name

  service_endpoints = ["Microsoft.AzureActiveDirectory"]
}

resource "azurerm_network_security_group" "vm" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "${var.resource_name_prefix}-sg"
  tags                = merge(var.tags, {})
}

resource "azurerm_subnet_network_security_group_association" "vm" {
  subnet_id                 = azurerm_subnet.vm.id
  network_security_group_id = azurerm_network_security_group.vm.id
}
