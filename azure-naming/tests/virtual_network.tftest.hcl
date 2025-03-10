run "virtual-network" {
  command = plan

  assert {
    condition = local.virtual_network.name == format(
      "%s-%s%s%s",
      local.virtual_network.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.RESOURCE_NAME}",
    )
    error_message = "virtual-network naming convention is incorrect"
  }
}
