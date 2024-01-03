run "database" {
  command = plan

  assert {
    condition     = azurerm_mssql_managed_database.starlight.managed_instance_id == data.azurerm_mssql_managed_instance.main.id
    error_message = "Database did not have the correct managed instance id"
  }

  assert {
    condition     = azurerm_mssql_managed_database.starlight.name == "${local.starlight_resource_name_prefix}-db"
    error_message = "Database did not have the correct name"
  }
}
