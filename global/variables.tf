locals {
}

variable "organization_name" {
  description = "Organization name"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(any)
}

data "azurerm_client_config" "current" {}
