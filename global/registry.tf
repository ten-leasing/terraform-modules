locals {
}

variable "container_registry_sku" {
  type        = string
  default     = "Standard"
  description = "'Premium' supports geo-replication and zone-redundancy as well as higher throughput and network capabilities"
}

resource "azurerm_container_registry" "organization" {
  resource_group_name = azurerm_resource_group.self.name
  location            = azurerm_resource_group.self.location
  name                = var.organization_name
  tags                = merge(var.tags, {})

  sku = var.container_registry_sku
}

output "registry_url" {
  value = azurerm_container_registry.organization.login_server
}
