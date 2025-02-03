run "managed-grafana" {
  command = plan

  assert {
    condition = local.managed_grafana == format(
      "%s-%s-%s%s",
      local.managed_grafana_config.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME,
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "managed-grafana naming convention is incorrect"
  }
}
