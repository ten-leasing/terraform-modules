data "azurerm_subscription" "current" {}

output "subscription_name" {
  value = data.azurerm_subscription.current.display_name
}

data "azurerm_client_config" "current" {}

data "azuread_directory_object" "current" {
  object_id = data.azurerm_client_config.current.object_id
}

data "azuread_service_principal" "current" {
  count     = data.azuread_directory_object.current.type == "ServicePrincipal" ? 1 : 0
  object_id = data.azurerm_client_config.current.object_id
}

data "azuread_user" "current" {
  count     = data.azuread_directory_object.current.type == "User" ? 1 : 0
  object_id = data.azurerm_client_config.current.object_id
}

output "provisioner_user_name" {
  value = (
    data.azuread_directory_object.current.type == "User" ?
    data.azuread_user.current.0.display_name :
    data.azuread_service_principal.current.0.display_name
  )
}

output "provisioner_object_id" {
  value = data.azurerm_client_config.current.object_id
}
