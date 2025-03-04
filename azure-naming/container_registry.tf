locals {
  container_registry_config = {
    abbrev = "cr"
    scope  = local.scopes.global
    parent = null
  }

  container_registry = format(
    "%s-%s-%s%s",
    local.container_registry_config.abbrev,
    var.ORG_KEY,
    var.RESOURCE_NAME,
    var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
  )
}

output "container_registry" { value = local.container_registry }
