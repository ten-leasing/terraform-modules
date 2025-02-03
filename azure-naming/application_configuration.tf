locals {
  application_configuration_config = {
    abbrev = "appcs"
    scope  = local.scopes.global
    parent = null
  }

  application_configuration = format(
    "%s-%s-%s%s",
    local.application_configuration_config.abbrev,
    var.ORG_KEY,
    var.RESOURCE_NAME,
    var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
  )
}

output "app_configuration_store" { value = local.application_configuration }
