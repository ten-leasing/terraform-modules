locals {
  virtual_network_gateway_connection_config = {
    abbrev = "vcn"
    scope  = local.scopes.parent
    parent = local.virtual_network_gateway_config
  }

  virtual_network_gateway_connection = format(
    "%s-%s",
    local.virtual_network_gateway_connection_config.abbrev,
    var.RESOURCE_NAME,
  )
}

output "virtual-network-gateway-connection" { value = local.virtual_network_gateway_connection }
