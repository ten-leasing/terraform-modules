run "managed-identity" {
  command = plan

  assert {
    condition = local.managed_identity.name == format(
      "%s%s",
      local.managed_identity.abbrev,
      var.WORKSPACE == "default" ? "" : "-${var.RESOURCE_NAME}",
    )
    error_message = "managed-identity naming convention is incorrect"
  }
}
