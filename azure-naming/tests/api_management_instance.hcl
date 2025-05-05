run "api-mangement-instance" {
  command = plan

  assert {
    condition = local.api_management_instance.name == format(
      "%s-%s%s%s",
      local.api_management_instance.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}",
    )
    error_message = "api-mangement-instance naming convention is incorrect"
  }
}
