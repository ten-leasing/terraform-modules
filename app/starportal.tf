locals {
  starportal_domain_id = regex(".*?\\.(.*?)\\.azurestaticapps.net", azurerm_static_site.starportal.default_host_name)[0]
}

variable "starportal_location" {
  type    = string
  default = "eastus2"
}

variable "starportal_custom_domain" {
  type = string
}

resource "azurerm_static_site" "starportal" {
  name                = "${var.resource_name_prefix}-site"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.starportal_location
  tags                = merge(var.tags, {})
}

output "starportal_hostname" {
  value = azurerm_static_site.starportal.default_host_name
}

resource "azurerm_static_site_custom_domain" "starportal" {
  static_site_id  = azurerm_static_site.starportal.id
  domain_name     = var.starportal_custom_domain
  validation_type = "cname-delegation"
}

output "starportal_custom_domain" {
  value = azurerm_static_site_custom_domain.starportal.domain_name
}
