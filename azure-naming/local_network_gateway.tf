locals {
  local_network_gateway_abbreviation = "lgw"
  local_network_gateway = {
    abbrev = local.local_network_gateway_abbreviation
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s-%s%s%s",
      local.local_network_gateway_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "local_network_gateway" { value = local.local_network_gateway }
