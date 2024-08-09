variable "enable_aad_extension" {
  type    = bool
  default = true
}

variable "type_handler_version" { type = string }

resource "azurerm_virtual_machine_extension" "aad_login" {
  count                      = var.enable_aad_extension ? 1 : 0
  provider                   = azurerm.current
  name                       = "AADLogin"
  tags                       = merge(var.tags, {})
  virtual_machine_id         = azurerm_windows_virtual_machine.self.id
  provision_after_extensions = []
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADLoginForWindows"
  type_handler_version       = var.type_handler_version
  automatic_upgrade_enabled  = false
  auto_upgrade_minor_version = false
}

resource "azuread_directory_role" "directory_reader" { display_name = "Directory Readers" }

resource "azuread_directory_role_assignment" "vm_entra_reader" {
  principal_object_id = one(azurerm_windows_virtual_machine.self.identity).principal_id
  role_id             = azuread_directory_role.directory_reader.template_id
}
