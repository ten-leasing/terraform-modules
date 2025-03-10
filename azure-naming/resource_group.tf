locals {
  resource_group_abbreviation = "rg"
  resource_group = {
    abbrev = local.resource_group_abbreviation
    scope  = local.scopes.subscription
    parent = null
    name = format(
      "%s-%s%s%s",
      local.resource_group_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "resource_group" { value = local.resource_group }
