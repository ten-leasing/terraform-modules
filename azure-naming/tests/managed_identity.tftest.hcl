run "managed-identity" {
  command = plan

  assert {
    condition = local.managed_identity == format(
      "%s-%s",
      local.managed_identity_config.abbrev,
      var.PROJECT_KEY,
    )
    error_message = "managed-identity naming convention is incorrect"
  }
}
