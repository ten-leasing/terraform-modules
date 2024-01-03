locals {
  managed_instance_subnet = cidrsubnet(azurerm_virtual_network.main.address_space, 0, 0)

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
  type = string
}

variable "service_tier" {
  type = string
}

variable "hardware_generation" {
  type = string
}

variable "v_cores" {
  type = number
}

variable "expose_to_public" {
  type    = bool
  default = false
}

resource "azurerm_subnet" "managed_instance" {
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  name                 = "ManagedInstance"
  address_prefixes     = [local.managed_instance_subnet]

  delegation {
    name = "managed_instance"
    service_delegation {
      name = "Microsoft.Sql/managedInstances"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
    }
  }
}

output "subnet_address_prefixes" {
  value = azurerm_subnet.managed_instance.address_prefixes
}

resource "azurerm_mssql_managed_instance" "self" {
  resource_group_name = azurerm_virtual_network.main.resource_group_name
  location            = azurerm_virtual_network.main.location
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

output "managed_instance_name" {
  value = azurerm_mssql_managed_instance.self.name
}

output "resource_group_name" {
  value = azurerm_mssql_managed_instance.self.resource_group_name
}

output "fqdn" {
  value = azurerm_mssql_managed_instance.self.fqdn
}
