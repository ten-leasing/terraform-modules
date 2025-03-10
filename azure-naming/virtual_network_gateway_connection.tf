locals {
  virtual_network_gateway_connection_abbreviation = "vcn"
  virtual_network_gateway_connection = {
    abbrev = local.virtual_network_gateway_connection_abbreviation
    scope  = local.scopes.parent
    parent = local.virtual_network_gateway
    name = format(
      "%s-%s%s%s",
      local.virtual_network_gateway_connection_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "virtual_network_gateway_connection" { value = local.virtual_network_gateway_connection }
