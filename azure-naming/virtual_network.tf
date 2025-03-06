locals {
  virtual_network_abbreviation = "vnet"
  virtual_network = {
    abbrev = local.virtual_network_abbreviation
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s-%s-%s",
      local.virtual_network_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME,
    )
  }
}

output "virtual_network" { value = local.virtual_network }
