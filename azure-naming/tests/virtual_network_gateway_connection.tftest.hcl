run "virtual-network-gateway-connection" {
  command = plan

  assert {
    condition = local.virtual_network_gateway_connection.name == format(
      "%s-%s%s%s",
      local.virtual_network_gateway_connection.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "virtual-network-gateway-connection naming convention is incorrect"
  }
}
