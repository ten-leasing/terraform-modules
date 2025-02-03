run "virtual-network-gateway" {
  command = plan

  assert {
    condition = local.virtual_network_gateway == format(
      "%s-%s",
      local.virtual_network_gateway_config.abbrev,
      var.RESOURCE_NAME,
    )
    error_message = "virtual-network-gateway naming convention is incorrect"
  }
}
