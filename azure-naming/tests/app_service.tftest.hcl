run "app-service" {
  command = plan

  # assert {
  #   condition     = local.app_service_environment == local.app_service_environment.abbrev
  #   error_message = "app-service environment naming convention is incorrect"
  # }

  assert {
    condition = local.app_service_plan.name == format(
      "%s%s%s",
      local.app_service_plan.abbrev,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}",
    )
    error_message = "app-service plan naming convention is incorrect"
  }

  assert {
    condition = local.app_service.name == format(
      "%s-%s%s%s",
      local.app_service.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "app-service naming convention is incorrect"
  }
}
