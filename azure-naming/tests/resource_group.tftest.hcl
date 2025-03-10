run "resource-group" {
  command = plan

  assert {
    condition = local.resource_group.name == format(
      "%s-%s%s%s",
      local.resource_group.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "resource-group naming convention is incorrect"
  }
}
