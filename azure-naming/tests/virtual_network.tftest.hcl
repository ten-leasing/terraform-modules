run "virtual-network" {
  command = plan

  assert {
    condition = local.virtual_network == format(
      "%s-%s",
      local.virtual_network_config.abbrev,
      var.PROJECT_KEY,
    )
    error_message = "virtual-network naming convention is incorrect"
  }
}
