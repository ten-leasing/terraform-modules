run "managed-grafana" {
  command = plan

  assert {
    condition = local.managed_grafana == format(
      "%s-%s",
      local.managed_grafana_config.abbrev,
      var.PROJECT_KEY,
    )
    error_message = "managed-grafana naming convention is incorrect"
  }
}
