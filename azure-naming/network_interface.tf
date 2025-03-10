locals {
  network_interface_abbreviation = "nic"
  network_interface = {
    abbrev = local.network_interface_abbreviation
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s-%s%s%s",
      local.network_interface_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "network_interface" { value = local.network_interface }
