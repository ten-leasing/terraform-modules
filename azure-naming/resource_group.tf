locals {
  resource_group_config = {
    abbrev = "rg"
    scope  = local.scopes.subscription
    parent = null
  }

  resource_group = format(
    "%s-%s",
    local.resource_group_config.abbrev,
    var.RESOURCE_NAME,
  )
}

output "resource_group" { value = local.resource_group }
