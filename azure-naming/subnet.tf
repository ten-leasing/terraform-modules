locals {
  subnet_abbreviation = "snet"
  subnet = {
    abbrev = local.subnet_abbreviation
    scope  = local.scopes.parent
    parent = local.virtual_network
    name = format(
      "%s%s%s",
      local.subnet_abbreviation,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}",
    )
  }
}

output "subnet" { value = local.subnet }
