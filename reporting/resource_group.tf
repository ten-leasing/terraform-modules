locals {
}

variable "location" {
  type    = string
  default = "eastus"
}

resource "azurerm_resource_group" "reporting" {
  location = var.location
  name     = "${var.resource_name_prefix}-reporting"
  tags     = merge(var.tags, {})
}

output "resource_group_name" {
  value = azurerm_resource_group.reporting.name
}

output "resource_group_location" {
  value = azurerm_resource_group.reporting.location
}
