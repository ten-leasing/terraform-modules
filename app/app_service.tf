locals {
  stargate_service_name = "stargate"
  starlock_service_name = "starlock"

  service_default_app_settings = {
    "JwtOptions__Issuer"              = "StarShipDevelopment",
    "JwtOptions__Audience"            = "StarPortalDevelopment",
    "JwtOptions__ExpirationInMinutes" = "30",
    "JwtOptions__Secret"              = random_password.jwt_secret.result,
    "WEBSITE_ENABLE_SYNC_UPDATE_SITE" = "true",
    "WEBSITE_RUN_FROM_PACKAGE"        = "1",
  }

  services = {
    starlock = {
      name         = "${var.resource_name_prefix}-${local.starlock_service_name}-app",
      app_settings = merge(local.service_default_app_settings, { "JwtOptions__ResetExpirationInMinutes" = "60", })
      connection_strings = {
        "StarLightConnectionString" : azurerm_mssql_managed_database.service[local.database_starlight_name].name,
        "StarLockConnectionString" : azurerm_mssql_managed_database.service[local.database_starlock_name].name,
      }
    }
    stargate = {
      name         = "${var.resource_name_prefix}-${local.stargate_service_name}-app",
      app_settings = merge(local.service_default_app_settings, {})
      connection_strings = {
        "StarLightConnectionString" : azurerm_mssql_managed_database.service[local.database_starlight_name].name,
      }
    }
  }
}

variable "app_service_sku_size" {
  type    = string
  default = "S1"
}

resource "random_password" "jwt_secret" { length = 72 }

resource "azurerm_service_plan" "plan" {
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tags                = merge(var.tags, {})
  name                = "${var.resource_name_prefix}-app-plan"

  lifecycle {
    create_before_destroy = true
  }

  os_type  = "Windows"
  sku_name = var.app_service_sku_size
}

resource "azurerm_windows_web_app" "app" {
  for_each = local.services

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tags                = merge(var.tags, {})
  name                = each.value.name

  service_plan_id = azurerm_service_plan.plan.id
  https_only      = true

  virtual_network_subnet_id = azurerm_subnet.service.id

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.app.id]
  }

  site_config {
    http2_enabled          = true
    vnet_route_all_enabled = true
    use_32_bit_worker      = false

    cors {
      support_credentials = true
      allowed_origins = [
        "https://*.${azurerm_static_site.starportal.location}.${local.starportal_domain_id}.azurestaticapps.net",
        "https://${azurerm_static_site.starportal.default_host_name}",
        "https://${azurerm_static_site_custom_domain.starportal.domain_name}",
      ]
    }

    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v6.0"
    }
  }

  app_settings = merge(each.value.app_settings, {})

  dynamic "connection_string" {
    for_each = each.value.connection_strings
    content {
      name = connection_string.key
      type = "SQLAzure"
      value = join(";",
        [
          "Server=${data.azurerm_mssql_managed_instance.main.fqdn},${local.managed_instance_default_port}",
          "Authentication=Active Directory Managed Identity",
          "Encrypt=True",
          "User Id=${azurerm_user_assigned_identity.app.client_id}",
          "Database=${connection_string.value}",
        ]
      )
    }
  }
}

output "default_hostnames" {
  value = {
    for each_service_name, each_service in azurerm_windows_web_app.app :
    "${each_service_name}_hostname" => each_service.default_hostname
  }
}

output "connection_strings" {
  sensitive = true
  value = {
    for each_service_name, each_service in azurerm_windows_web_app.app :
    "${each_service_name}_connection_strings" => nonsensitive(each_service.connection_string)
  }
}
