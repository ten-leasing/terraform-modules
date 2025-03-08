locals {
  virtual_network_gateway_abbreviation = "vgw"
  virtual_network_gateway = {
    abbrev = local.virtual_network_gateway_abbreviation
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s-%s%s",
      local.virtual_network_gateway_abbreviation,
      var.ORG_KEY,
      var.WORKSPACE == "default" ? "" : "-${var.RESOURCE_NAME}",
    )
  }
}

output "virtual_network_gateway" { value = local.virtual_network_gateway }
