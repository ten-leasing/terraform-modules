run "log-analytics-workspace" {
  command = plan

  assert {
    condition = local.log_analytics_workspace.name == format(
      "%s-%s%s",
      local.log_analytics_workspace.abbrev,
      var.ORG_KEY,
      var.WORKSPACE == "default" ? "" : "-${var.RESOURCE_NAME}",
    )
    error_message = "log-analytics-workspace naming convention is incorrect"
  }
}
