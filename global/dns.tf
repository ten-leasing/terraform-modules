# Currently unused
resource "azurerm_dns_zone" "organization" {
  resource_group_name = azurerm_resource_group.self.name
  tags                = merge(var.tags, {})
  name                = "${var.organization_name}.com"
}
