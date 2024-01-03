locals {
}

variable "automation_client_secret" {
  type      = string
  sensitive = true
}

variable "key_vault_sku" {
  type        = string
  default     = "standard"
  description = "'premium' supports HSM keys"
}

resource "azurerm_key_vault" "organization" {
  tenant_id           = data.azurerm_client_config.current.tenant_id
  resource_group_name = azurerm_resource_group.self.name
  location            = azurerm_resource_group.self.location
  sku_name            = var.key_vault_sku
  name                = var.organization_name
  tags                = merge(var.tags, {})

  purge_protection_enabled      = false
  public_network_access_enabled = true
  enable_rbac_authorization     = true
}

resource "azurerm_key_vault_secret" "automation_client_secret" {
  key_vault_id = azurerm_key_vault.organization.id
  name         = "automation-client-secret"
  tags         = merge(var.tags, {})

  value = var.automation_client_secret
}
