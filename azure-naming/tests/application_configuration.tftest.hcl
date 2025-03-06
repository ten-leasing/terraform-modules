run "application-configuration" {
  command = plan

  assert {
    condition = local.application_configuration.name == format(
      "%s-%s-%s",
      local.application_configuration.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME
    )
    error_message = "application-configuration naming convention is incorrect"
  }
}
