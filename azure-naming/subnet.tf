locals {
  subnet_config = {
    abbrev = "snet"
    scope  = local.scopes.parent
    parent = local.virtual_network
  }

  subnet = format(
    "%s-%s",
    local.subnet_config.abbrev,
    var.RESOURCE_NAME,
  )
}

output "subnet" { value = local.subnet }
