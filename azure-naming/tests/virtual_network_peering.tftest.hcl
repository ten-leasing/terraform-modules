run "virtual-network-peering" {
  command = plan

  assert {
    condition = local.virtual_network_peering.name == format(
      "%s%s",
      local.virtual_network_peering.abbrev,
      var.WORKSPACE == "default" ? "" : "-${var.RESOURCE_NAME}",
    )
    error_message = "virtual-network-peering naming convention is incorrect"
  }
}
