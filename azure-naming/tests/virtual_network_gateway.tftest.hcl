run "virtual-network-gateway" {
  command = plan

  assert {
    condition = local.virtual_network_gateway.name == format(
      "%s-%s%s",
      local.virtual_network_gateway.abbrev,
      var.ORG_KEY,
      var.WORKSPACE == "default" ? "" : "-${var.RESOURCE_NAME}",
    )
    error_message = "virtual-network-gateway naming convention is incorrect"
  }
}
