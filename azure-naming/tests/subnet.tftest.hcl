run "subnet" {
  command = plan

  assert {
    condition = local.subnet.name == format(
      "%s%s%s",
      local.subnet.abbrev,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}",
    )
    error_message = "subnet naming convention is incorrect"
  }
}
