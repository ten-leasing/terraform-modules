run "resource-group" {
  command = plan

  assert {
    condition = local.resource_group.name == format(
      "%s-%s-%s",
      local.resource_group.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME,
    )
    error_message = "resource-group naming convention is incorrect"
  }
}
