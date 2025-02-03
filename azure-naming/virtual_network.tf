locals {
  virtual_network_config = {
    abbrev = "vnet"
    scope  = local.scopes.resource_group
    parent = local.resource_group_config
  }

  virtual_network = format(
    "%s-%s",
    local.virtual_network_config.abbrev,
    var.RESOURCE_NAME,
  )
}

output "virtual_network" { value = local.virtual_network }
