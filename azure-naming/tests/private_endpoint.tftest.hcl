run "private-endpoint" {
  command = plan

  assert {
    condition = local.private_endpoint.name == format(
      "%s-%s%s%s",
      local.private_endpoint.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "private-endpoint naming convention is incorrect"
  }
}
