resource "azurerm_public_ip" "gateway" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "${var.resource_name_prefix}-internal-vgw-pip"
  tags                = merge(var.tags, {})
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "${var.resource_name_prefix}-gw"
}

output "gateway_public_ip_domain_name" {
  value = azurerm_public_ip.gateway.domain_name_label
}

output "gateway_public_ip_id" {
  value = azurerm_public_ip.gateway.id
}

output "gateway_public_ip" {
  value = azurerm_public_ip.gateway.ip_address
}
