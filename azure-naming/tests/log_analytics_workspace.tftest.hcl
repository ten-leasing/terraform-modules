run "log-analytics-workspace" {
  command = plan

  assert {
    condition = local.log_analytics_workspace == format(
      "%s-%s",
      local.log_analytics_workspace_config.abbrev,
      var.RESOURCE_NAME,
    )
    error_message = "log-analytics-workspace naming convention is incorrect"
  }
}
