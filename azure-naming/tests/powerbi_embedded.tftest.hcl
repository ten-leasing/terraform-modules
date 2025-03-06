run "powerbi-embedded" {
  command = plan

  assert {
    condition = local.powerbi_embedded.name == format(
      "%s%s%s%s",
      local.powerbi_embedded.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME,
      var.LOCATION,
    )
    error_message = "powerbi-embedded naming convention is incorrect"
  }
}
