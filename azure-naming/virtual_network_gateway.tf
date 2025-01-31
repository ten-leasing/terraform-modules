locals {
  virtual_network_gateway_config = {
    abbrev = "vgw"
    scope  = local.scopes.resource_group
    parent = local.resource_group_config
  }

  virtual_network_gateway = format(
    "%s-%s",
    local.virtual_network_gateway_config.abbrev,
    var.PROJECT_KEY,
  )
}

output "virtual-network-gateway" { value = local.virtual_network_gateway }
