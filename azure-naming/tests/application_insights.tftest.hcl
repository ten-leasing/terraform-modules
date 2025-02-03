run "application-insights" {
  command = plan

  assert {
    condition = local.application_insights == format(
      "%s-%s",
      local.application_insights_config.abbrev,
      var.RESOURCE_NAME,
    )
    error_message = "application-insights naming convention is incorrect"
  }
}
