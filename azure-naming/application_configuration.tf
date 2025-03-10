locals {
  application_configuration_abbreviation = "appcs"
  application_configuration = {
    abbrev = local.application_configuration_abbreviation
    scope  = local.scopes.global
    parent = local.resource_group
    name = format(
      "%s-%s%s%s",
      local.application_configuration_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "app_configuration_store" { value = local.application_configuration }
