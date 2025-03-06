locals {
  subnet_abbreviation = "snet"
  subnet = {
    abbrev = local.subnet_abbreviation
    scope  = local.scopes.parent
    parent = local.virtual_network
    name = format(
      "%s-%s",
      local.subnet_abbreviation,
      var.RESOURCE_NAME,
    )
  }
}

output "subnet" { value = local.subnet }
