locals {
  virtual_network_peering_abbreviation = "peer"
  virtual_network_peering = {
    abbrev = local.virtual_network_peering_abbreviation
    scope  = local.scopes.parent
    parent = local.virtual_network
    name = format(
      "%s%s%s",
      local.virtual_network_peering_abbreviation,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "virtual_network_peering" { value = local.virtual_network_peering }
