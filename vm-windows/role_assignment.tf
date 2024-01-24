variable "logins" {
  type = object({
    users  = map(string)
    admins = map(string)
  })
}

resource "azurerm_role_assignment" "users" {
  for_each             = var.logins.users
  principal_id         = each.value
  scope                = azurerm_windows_virtual_machine.emulator.id
  role_definition_name = "Virtual Machine User Login"
}

resource "azurerm_role_assignment" "admins" {
  for_each             = var.logins.admins
  principal_id         = each.value
  scope                = azurerm_windows_virtual_machine.emulator.id
  role_definition_name = "Virtual Machine Administrator Login"
}
