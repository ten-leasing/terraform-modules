run "private-endpoint" {
  command = plan

  assert {
    condition = local.private_endpoint.name == format(
      "%s-%s",
      local.private_endpoint.abbrev,
      var.RESOURCE_NAME,
    )
    error_message = "private-endpoint naming convention is incorrect"
  }
}
