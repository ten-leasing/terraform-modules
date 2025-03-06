run "virtual-machine" {
  command = plan

  assert {
    condition = local.virtual_machine.name == format(
      "%s-%s",
      local.virtual_machine.abbrev,
      var.RESOURCE_NAME,
    )
    error_message = "virtual-machine naming convention is incorrect"
  }
}
