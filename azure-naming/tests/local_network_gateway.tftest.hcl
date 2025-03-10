run "local-network-gateway" {
  command = plan

  assert {
    condition = local.local_network_gateway.name == format(
      "%s-%s%s%s",
      local.local_network_gateway.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "local-network-gateway naming convention is incorrect"
  }
}
