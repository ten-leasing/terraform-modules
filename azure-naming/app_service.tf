locals {
  app_service_environment_abbreviation = "ase"
  app_service_environment = {
    abbrev = local.app_service_environment_abbreviation
    scope  = local.scopes.global
    parent = local.resource_group
    name = format(
      "%s-%s-%s%s",
      local.app_service_environment_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME,
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }

  app_service_plan_abbreviation = "asp"
  app_service_plan = {
    abbrev = local.app_service_plan_abbreviation
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s%s",
      local.app_service_plan_abbreviation,
      var.WORKSPACE == "default" ? "" : "-${var.RESOURCE_NAME}",
    )
  }

  app_service_abbreviation = "app"
  app_service = {
    abbrev = local.app_service_abbreviation
    scope  = local.scopes.global
    parent = local.app_service_plan
    name = format(
      "%s-%s-%s%s",
      local.app_service_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME,
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

# output "app-service-environment" { value = local.app_service_environment }
output "app_service_plan" { value = local.app_service_plan }
output "app_service" { value = local.app_service }
