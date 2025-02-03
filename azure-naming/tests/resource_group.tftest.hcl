run "resource-group" {
  command = plan

  assert {
    condition = local.resource_group == format(
      "%s-%s",
      local.resource_group_config.abbrev,
      var.RESOURCE_NAME,
    )
    error_message = "resource-group naming convention is incorrect"
  }
}
