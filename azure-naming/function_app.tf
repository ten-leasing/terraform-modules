locals {
  function_app_config = {
    abbrev = "func"
    scope  = local.scopes.global
    parent = local.app_service_plan_config
  }

  function_app = format(
    "%s-%s-%s%s",
    local.function_app_config.abbrev,
    var.ORG_KEY,
    var.PROJECT_KEY,
    var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
  )
}

output "function-app" { value = local.function_app }
