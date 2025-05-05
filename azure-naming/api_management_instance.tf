locals {
  api_management_instance_abbreviation = "apim"
  api_management_instance = {
    abbrev = local.api_management_instance_abbreviation
    scope  = local.scopes.global
    parent = local.resource_group
    name = format(
      "%s-%s%s%s",
      local.api_management_instance_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "api_management_instance" { value = local.api_management_instance }
