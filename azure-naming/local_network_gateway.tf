locals {
  local_network_gateway_config = {
    abbrev = "lgw"
    scope  = local.scopes.resource_group
    parent = local.resource_group_config
  }

  local_network_gateway = format(
    "%s-%s",
    local.local_network_gateway_config.abbrev,
    var.RESOURCE_NAME,
  )
}

output "local_network_gateway" { value = local.local_network_gateway }
