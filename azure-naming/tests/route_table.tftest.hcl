run "route-table" {
  command = plan

  assert {
    condition = local.route_table.name == format(
      "%s%s",
      local.route_table.abbrev,
      var.WORKSPACE == "default" ? "" : "-${var.RESOURCE_NAME}",
    )
    error_message = "route-table naming convention is incorrect"
  }
}
