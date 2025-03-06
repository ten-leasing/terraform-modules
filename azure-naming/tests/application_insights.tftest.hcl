run "application-insights" {
  command = plan

  assert {
    condition = local.application_insights.name == format(
      "%s-%s-%s",
      local.application_insights.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME,
    )
    error_message = "application-insights naming convention is incorrect"
  }
}
