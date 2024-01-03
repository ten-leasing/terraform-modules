locals {
  service_tiers = {
    "General Purpose" : "GP",
    "Business Critical" : "BC",
  }
  hardware_generations = {
    "Standard" : "Gen5",
    "Premium" : "Gen8IM",
    "Premium-Optimized" : "Gen8IH",
  }
}

variable "storage_account_type" {
  type    = string
  default = "LRS"
}

variable "service_tier" {
  type    = string
  default = "General Purpose"
}

variable "hardware_generation" {
  type    = string
  default = "Standard"
}

variable "v_cores" {
  type    = number
  default = 4
}

variable "expose_to_public" {
  type    = bool
  default = true # This should be set to false in near future
}

resource "azurerm_mssql_managed_instance" "self" {
  resource_group_name = azurerm_resource_group.data.name
  location            = azurerm_resource_group.data.location
  tags                = merge(var.tags, {})

  name = "${var.resource_name_prefix}-mi"

  administrator_login          = random_pet.admin_user.id
  administrator_login_password = random_password.admin_password.result

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.managed_instance.id]
  }

  license_type                 = "BasePrice"
  sku_name                     = "${local.service_tiers[var.service_tier]}_${local.hardware_generations[var.hardware_generation]}"
  storage_size_in_gb           = 32
  storage_account_type         = var.storage_account_type
  subnet_id                    = azurerm_subnet.managed_instance.id
  vcores                       = var.v_cores
  public_data_endpoint_enabled = var.expose_to_public
}

output "managed_instance_fqdn" {
  value = azurerm_mssql_managed_instance.self.fqdn
}
