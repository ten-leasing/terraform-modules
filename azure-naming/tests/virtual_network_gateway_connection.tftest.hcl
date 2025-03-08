run "virtual-network-gateway-connection" {
  command = plan

  assert {
    condition = local.virtual_network_gateway_connection.name == format(
      "%s-%s%s",
      local.virtual_network_gateway_connection.abbrev,
      var.ORG_KEY,
      var.WORKSPACE == "default" ? "" : "-${var.RESOURCE_NAME}",
    )
    error_message = "virtual-network-gateway-connection naming convention is incorrect"
  }
}
