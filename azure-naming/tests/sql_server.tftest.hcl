run "mssql-server" {
  command = plan

  assert {
    condition = local.mssql_server.name == format(
      "%s-%s-%s%s",
      local.mssql_server.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME,
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "mssql-server naming convention is incorrect"
  }
}
