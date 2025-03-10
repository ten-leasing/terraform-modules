run "virtual-network-peering" {
  command = plan

  assert {
    condition = local.virtual_network_peering.name == format(
      "%s%s%s",
      local.virtual_network_peering.abbrev,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "virtual-network-peering naming convention is incorrect"
  }
}
