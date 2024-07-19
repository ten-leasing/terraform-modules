locals {
  virtual_network_resource_group_name = var.virtual_network_resource_group_name == null ? var.resource_group_name : var.virtual_network_resource_group_name
}

variable "virtual_network_resource_group_name" { type = string }
variable "virtual_network_name" { type = string }
variable "subnet_address_prefixes" { type = list(string) }
variable "subnet_private_endpoint_network_policies_enabled" {
  type    = bool
  default = true
}

resource "azurerm_subnet" "vm" {
  provider             = azurerm.current
  resource_group_name  = local.virtual_network_resource_group_name
  virtual_network_name = var.virtual_network_name
  name                 = var.vm_name

  address_prefixes                              = var.subnet_address_prefixes
  service_endpoints                             = ["Microsoft.AzureActiveDirectory"]
  service_endpoint_policy_ids                   = []
  private_endpoint_network_policies             = var.subnet_private_endpoint_network_policies_enabled ? "Enabled" : "Disabled"
  private_link_service_network_policies_enabled = var.subnet_private_endpoint_network_policies_enabled
}

output "subnet" { value = azurerm_subnet.vm }

resource "azurerm_network_interface" "vm" {
  provider            = azurerm.current
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "${azurerm_subnet.vm.name}-nic"
  tags                = merge(var.tags, {})

  ip_configuration {
    name                          = "${azurerm_subnet.vm.name}-ip_config"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vm.id
  }
}

resource "azurerm_network_security_group" "vm" {
  provider            = azurerm.current
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "${azurerm_subnet.vm.name}-sg"
  tags                = merge(var.tags, {})
}

resource "azurerm_subnet_network_security_group_association" "vm" {
  provider                  = azurerm.current
  subnet_id                 = azurerm_subnet.vm.id
  network_security_group_id = azurerm_network_security_group.vm.id
}
