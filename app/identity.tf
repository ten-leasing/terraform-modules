resource "azurerm_user_assigned_identity" "app" {
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tags                = merge(var.tags, {})

  name = "${var.resource_name_prefix}-stargazer"
}

output "app_user_managed_identity_name" {
  value = azurerm_user_assigned_identity.app.name
}

output "app_user_managed_identity_client_id" {
  value = azurerm_user_assigned_identity.app.client_id
}
