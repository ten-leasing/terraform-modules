locals {
}

variable "storage_account_tier" {
  type        = string
  default     = "Standard"
  description = "'Premium' may be best for high-latency scenarios"
}

variable "storage_account_replication_type" {
  type    = string
  default = "LRS"
}

resource "azurerm_storage_account" "organization" {
  resource_group_name = azurerm_resource_group.self.name
  location            = azurerm_resource_group.self.location
  tags                = merge(var.tags, {})
  name                = "starleasing"

  account_tier                    = var.storage_account_tier
  account_replication_type        = var.storage_account_replication_type
  shared_access_key_enabled       = false
  default_to_oauth_authentication = true
}

resource "azurerm_storage_container" "terraform" {
  storage_account_name = azurerm_storage_account.organization.name
  name                 = "terraform"
}
