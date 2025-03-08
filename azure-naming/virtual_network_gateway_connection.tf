locals {
  virtual_network_gateway_connection_abbreviation = "vcn"
  virtual_network_gateway_connection = {
    abbrev = local.virtual_network_gateway_connection_abbreviation
    scope  = local.scopes.parent
    parent = local.virtual_network_gateway
    name = format(
      "%s-%s%s",
      local.virtual_network_gateway_connection_abbreviation,
      var.ORG_KEY,
      var.WORKSPACE == "default" ? "" : "-${var.RESOURCE_NAME}",
    )
  }
}

output "virtual_network_gateway_connection" { value = local.virtual_network_gateway_connection }
