run "network-interface" {
  command = plan

  assert {
    condition = local.network_interface.name == format(
      "%s-%s",
      local.network_interface.abbrev,
      var.RESOURCE_NAME,
    )
    error_message = "network-interface naming convention is incorrect"
  }
}
