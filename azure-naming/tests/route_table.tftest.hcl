run "route-table" {
  command = plan

  assert {
    condition = local.route_table == format(
      "%s-%s",
      local.route_table_config.abbrev,
      var.RESOURCE_NAME,
    )
    error_message = "route-table naming convention is incorrect"
  }
}
