locals {
  virtual_network_peering_config = {
    abbrev = "peer"
    scope  = local.scopes.parent
    parent = local.virtual_network
  }

  virtual_network_peering = format(
    "%s-%s",
    local.virtual_network_peering_config.abbrev,
    var.PROJECT_KEY,
  )
}

output "virtual_network_peering" { value = local.virtual_network_peering }
