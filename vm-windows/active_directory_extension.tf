resource "azurerm_virtual_machine_extension" "aad_login" {
  name                       = "AADLogin"
  tags                       = merge(var.tags, {})
  virtual_machine_id         = azurerm_windows_virtual_machine.emulator.id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADLoginForWindows"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}
