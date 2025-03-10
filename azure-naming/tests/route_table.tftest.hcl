run "route-table" {
  command = plan

  assert {
    condition = local.route_table.name == format(
      "%s%s%s",
      local.route_table.abbrev,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "route-table naming convention is incorrect"
  }
}
