# Ensure connection string for stargate use the appropriate DB names

# Ensure connection string for starlock use the appropriate DB names

run "services" {
  assert {
    condition = (azurerm_windows_web_app.app[local.starlock_service_name].default_hostname
    == "${local.services[local.starlock_service_name].name}.azurewebsites.net")
    error_message = "starlock hostname was unexpected"
  }

  assert {
    condition = (azurerm_windows_web_app.app[local.stargate_service_name].default_hostname
    == "${local.services[local.stargate_service_name].name}.azurewebsites.net")
    error_message = "stargate hostname was unexpected"
  }
}
