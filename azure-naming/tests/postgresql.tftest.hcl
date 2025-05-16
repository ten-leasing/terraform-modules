run "postgresql" {
  command = plan

  assert {
    condition = local.postgresql_server.name == format(
      "%s-%s%s%s",
      local.postgresql_server.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "postgresql-server naming convention is incorrect"
  }
}
