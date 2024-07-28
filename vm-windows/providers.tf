terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "< 4"
      configuration_aliases = [azurerm.current]
    }
  }
}

data "azurerm_subscription" "current" { provider = azurerm.current }
output "subscription_name" { value = data.azurerm_subscription.current.display_name }
