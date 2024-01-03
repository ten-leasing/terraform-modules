variable "server_admin_group_display_name" {
  type    = string
  default = "IT - DevOps - Administrators"
}

variable "password_length" {
  type    = number
  default = 16
}

resource "random_pet" "admin_user" {}

output "admin_user" {
  value = random_pet.admin_user.id
}

resource "random_password" "admin_password" {
  length = var.password_length
}

output "admin_password" {
  value     = random_password.admin_password.result
  sensitive = true
}

data "azurerm_client_config" "current" {}

data "azuread_group" "devops_admin" {
  display_name = var.server_admin_group_display_name
}

data "azuread_application_published_app_ids" "ids" {}

data "azuread_service_principal" "msgraph" {
  client_id = data.azuread_application_published_app_ids.ids.result.MicrosoftGraph
}

resource "azurerm_user_assigned_identity" "managed_instance" {
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = merge(var.tags, {})

  name = "${var.resource_name_prefix}-mi-identity"
}

resource "azuread_directory_role" "directory_reader" {
  display_name = "Directory Readers"
}

resource "azuread_directory_role_assignment" "managed_instance" {
  principal_object_id = azurerm_user_assigned_identity.managed_instance.principal_id
  role_id             = azuread_directory_role.directory_reader.template_id
}

resource "azurerm_mssql_managed_instance_active_directory_administrator" "admin" {
  depends_on          = [azuread_directory_role_assignment.managed_instance, ]
  tenant_id           = data.azurerm_client_config.current.tenant_id
  managed_instance_id = azurerm_mssql_managed_instance.self.id

  azuread_authentication_only = true

  object_id      = data.azuread_group.devops_admin.object_id
  login_username = data.azuread_group.devops_admin.display_name
}
