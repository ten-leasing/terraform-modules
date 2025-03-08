run "subnet" {
  command = plan

  assert {
    condition = local.subnet.name == format(
      "%s%s",
      local.subnet.abbrev,
      var.WORKSPACE == "default" ? "" : "-${var.RESOURCE_NAME}",
    )
    error_message = "subnet naming convention is incorrect"
  }
}
