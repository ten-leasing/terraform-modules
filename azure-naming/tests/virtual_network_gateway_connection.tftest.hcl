run "virtual-network-gateway-connection" {
  command = plan

  assert {
    condition = local.virtual_network_gateway_connection == format(
      "%s-%s",
      local.virtual_network_gateway_connection_config.abbrev,
      var.RESOURCE_NAME,
    )
    error_message = "virtual-network-gateway-connection naming convention is incorrect"
  }
}
