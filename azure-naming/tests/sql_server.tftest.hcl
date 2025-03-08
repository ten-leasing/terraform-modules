run "sql-server" {
  command = plan

  assert {
    condition = local.sql_server.name == format(
      "%s-%s-%s%s",
      local.sql_server.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME,
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "sql-server naming convention is incorrect"
  }
}
