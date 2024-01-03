locals {
}

variable "location" {
  type    = string
  default = "eastus"
}

resource "azurerm_resource_group" "images" {
  location = var.location
  name     = "${var.resource_name_prefix}-images"
  tags     = merge(var.tags, {})
}

output "resource_group_name" {
  value = azurerm_resource_group.images.name
}

output "resource_group_location" {
  value = azurerm_resource_group.images.location
}
