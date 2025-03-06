run "container-registry" {
  command = plan

  assert {
    condition = local.container_registry.name == format(
      "%s%s%s%s",
      local.container_registry.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME,
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "container-registry naming convention is incorrect"
  }
}
