locals {
  virtual_machine_config = {
    abbrev = "vm"
    scope  = local.scopes.resource_group
    parent = local.resource_group_config
  }

  virtual_machine = format(
    "%s-%s",
    local.virtual_machine_config.abbrev,
    var.PROJECT_KEY,
  )
}

output "virtual_machine" { value = local.virtual_machine }
