variable "virtual_network_name" {
  type = string
}

variable "subnet_address_prefixes" {
  type = list(string)
}

resource "azurerm_subnet" "vm" {
  provider             = azurerm.current
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  name                 = local.computer_name

  address_prefixes  = var.subnet_address_prefixes
  service_endpoints = ["Microsoft.AzureActiveDirectory"]
}

resource "azurerm_network_interface" "vm" {
  provider            = azurerm.current
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "${local.computer_name}-nic"
  tags                = merge(var.tags, {})

  ip_configuration {
    name                          = "${local.computer_name}-ip_config"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vm.id
  }

  lifecycle {
    replace_triggered_by = [azurerm_subnet.vm]
  }
}

resource "azurerm_network_security_group" "vm" {
  provider            = azurerm.current
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "${local.computer_name}-sg"
  tags                = merge(var.tags, {})
}

resource "azurerm_subnet_network_security_group_association" "vm" {
  provider                  = azurerm.current
  subnet_id                 = azurerm_subnet.vm.id
  network_security_group_id = azurerm_network_security_group.vm.id
}
