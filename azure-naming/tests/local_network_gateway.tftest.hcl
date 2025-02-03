run "local-network-gateway" {
  command = plan

  assert {
    condition = local.local_network_gateway == format(
      "%s-%s",
      local.local_network_gateway_config.abbrev,
      var.RESOURCE_NAME,
    )
    error_message = "local-network-gateway naming convention is incorrect"
  }
}
