locals {
  container_registry_abbreviation = "cr"
  container_registry = {
    abbrev = local.container_registry_abbreviation
    scope  = local.scopes.global
    parent = local.resource_group
    name = format(
      "%s%s%s%s",
      local.container_registry_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME,
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "container_registry" { value = local.container_registry }
