locals {
  app_service_environment_config = {
    abbrev = "ase"
    scope  = local.scopes.global
    parent = null
  }

  app_service_plan_config = {
    abbrev = "asp"
    scope  = local.scopes.subscription
    parent = null
  }

  app_service_config = {
    abbrev = "app"
    scope  = local.scopes.global
    parent = local.app_service_plan_config
  }

  # app_service_environment = local.app_service_environment_config.abbrev

  app_service_plan = format(
    "%s-%s-%s",
    local.app_service_plan_config.abbrev,
    var.ORG_KEY,
    var.SUBSCRIPTION_NAME
  )

  app_service = format(
    "%s-%s-%s%s",
    local.app_service_config.abbrev,
    var.ORG_KEY,
    var.PROJECT_KEY,
    var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
  )
}

# output "app-service-environment" { value = local.app_service_environment }
output "app_service_plan" { value = local.app_service_plan }
output "app_service" { value = local.app_service }
