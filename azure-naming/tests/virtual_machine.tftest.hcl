run "virtual-machine" {
  command = plan

  assert {
    condition = local.virtual_machine == format(
      "%s-%s",
      local.virtual_machine_config.abbrev,
      var.RESOURCE_NAME,
    )
    error_message = "virtual-machine naming convention is incorrect"
  }
}
