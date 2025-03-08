locals {
  virtual_network_peering_abbreviation = "peer"
  virtual_network_peering = {
    abbrev = local.virtual_network_peering_abbreviation
    scope  = local.scopes.parent
    parent = local.virtual_network
    name = format(
      "%s%s",
      local.virtual_network_peering_abbreviation,
      var.WORKSPACE == "default" ? "" : "-${var.RESOURCE_NAME}",
    )
  }
}

output "virtual_network_peering" { value = local.virtual_network_peering }
