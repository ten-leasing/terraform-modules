locals {
  virtual_machine_abbreviation = "vm"
  virtual_machine = {
    abbrev = local.virtual_machine_abbreviation
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s%s%s",
      local.virtual_machine_abbreviation,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "virtual_machine" { value = local.virtual_machine }
