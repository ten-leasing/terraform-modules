run "resource_group" {
  command = plan

  assert {
    condition     = azurerm_resource_group.main.name == local.env
    error_message = "Resource group did not have the correct name"
  }

  assert {
    condition     = azurerm_resource_group.main.location == local.location
    error_message = "Resource group did not have the correct location"
  }
}
