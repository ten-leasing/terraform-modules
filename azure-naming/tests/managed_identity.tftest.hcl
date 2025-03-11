run "managed-identity" {
  command = plan

  assert {
    condition = local.managed_identity.name == format(
      "%s%s%s",
      local.managed_identity.abbrev,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}",
    )
    error_message = "managed-identity naming convention is incorrect"
  }
}
