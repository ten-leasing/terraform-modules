locals {
  function_app_abbreviation = "func"
  function_app = {
    abbrev = local.function_app_abbreviation
    scope  = local.scopes.global
    parent = local.app_service_plan
    name = format(
      "%s-%s%s%s",
      local.function_app_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "function_app" { value = local.function_app }
