locals {
}

variable "location" {
  type    = string
  default = "eastus"
}

resource "azurerm_resource_group" "self" {
  location = var.location
  name     = "global"
  tags     = merge(var.tags, {})
}

output "resource_group_name" {
  value = azurerm_resource_group.self.name
}

output "resource_group_location" {
  value = azurerm_resource_group.self.location
}
