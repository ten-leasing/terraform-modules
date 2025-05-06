run "monitor_workspace" {
  command = plan

  assert {
    condition = local.monitor_workspace.name == format(
      "%s-%s%s%s",
      local.monitor_workspace.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "monitor-workspace naming convention is incorrect"
  }
}
