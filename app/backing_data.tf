locals {
  database_starlock_name        = "starlock"
  database_starlight_name       = "starlight"
  managed_instance_default_port = 1433
  databases = {
    (local.database_starlock_name) = {
      (azurerm_user_assigned_identity.app.name) : ["db_datareader", "db_datawriter"]
    }
    (local.database_starlight_name) = {
      (azurerm_user_assigned_identity.app.name) : ["db_datareader", "db_datawriter"]
    }
  }
  database_logins = flatten([
    for database_name, database_logins in local.databases : flatten([
      for user, roles in database_logins : flatten([
        for role in roles : {
          database = database_name
          user     = user
          role     = role
        }
      ])
    ])
  ])
  database_login_map = {
    for m in local.database_logins : "${m.database}.${m.user}.${m.role}" => {
      database = m.database
      user     = m.user
      role     = m.role
    }
  }
}

output "database_logins" {
  value = local.database_logins
}

data "azurerm_virtual_network" "managed_instance" {
  resource_group_name = "${var.resource_name_prefix}-data"
  name                = "${var.resource_name_prefix}-mi-vnet"
}

data "azurerm_mssql_managed_instance" "main" {
  resource_group_name = "${var.resource_name_prefix}-data"
  name                = "${var.resource_name_prefix}-mi"
}

resource "azurerm_mssql_managed_database" "service" {
  for_each            = local.databases
  managed_instance_id = data.azurerm_mssql_managed_instance.main.id
  name                = "${var.resource_name_prefix}-${each.key}-db"
}

output "database_names" {
  value = [for each_database in azurerm_mssql_managed_database.service : each_database.name]
}

resource "null_resource" "database_user" {
  for_each = local.database_login_map

  triggers = {
    identity    = azurerm_user_assigned_identity.app.id,
    service     = azurerm_mssql_managed_database.service[each.value.database].id,
    force_rerun = 1
  }

  provisioner "local-exec" {
    command = join("", [
      "sqlcmd -G -h -1 -Q \"",
      "CREATE USER [${each.value.user}] FROM EXTERNAL PROVIDER;",
      "ALTER ROLE ${each.value.role} ADD MEMBER [${each.value.user}];",
      "\"",
    ])
    environment = {
      SQLCMDDBNAME = azurerm_mssql_managed_database.service[each.value.database].name
      SQLCMDSERVER = "${data.azurerm_mssql_managed_instance.main.fqdn}"
    }
  }
}
