run "virtual-network-peering" {
  command = plan

  assert {
    condition = local.virtual_network_peering == format(
      "%s-%s",
      local.virtual_network_peering_config.abbrev,
      var.RESOURCE_NAME,
    )
    error_message = "virtual-network-peering naming convention is incorrect"
  }
}
