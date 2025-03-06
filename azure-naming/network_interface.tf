locals {
  network_interface_abbreviation = "nic"
  network_interface = {
    abbrev = local.network_interface_abbreviation
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s-%s",
      local.network_interface_abbreviation,
      var.RESOURCE_NAME,
    )
  }
}

output "network_interface" { value = local.network_interface }
