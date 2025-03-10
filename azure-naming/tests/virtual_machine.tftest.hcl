run "virtual-machine" {
  command = plan

  assert {
    condition = local.virtual_machine.name == format(
      "%s%s%s",
      local.virtual_machine.abbrev,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "virtual-machine naming convention is incorrect"
  }
}
