run "network-interface" {
  command = plan

  assert {
    condition = local.network_interface.name == format(
      "%s-%s%s%s",
      local.network_interface.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "network-interface naming convention is incorrect"
  }
}
