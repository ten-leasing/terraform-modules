run "app-service" {
  command = plan

  # assert {
  #   condition     = local.app_service_environment == local.app_service_environment_config.abbrev
  #   error_message = "app-service environment naming convention is incorrect"
  # }

  assert {
    condition = local.app_service_plan == format(
      "%s-%s",
      local.app_service_plan_config.abbrev,
      var.RESOURCE_NAME,
    )
    error_message = "app-service plan naming convention is incorrect"
  }

  assert {
    condition = local.app_service == format(
      "%s-%s-%s%s",
      local.app_service_config.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME,
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "app-service naming convention is incorrect"
  }
}
