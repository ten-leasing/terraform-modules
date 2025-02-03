run "key-vault" {
  command = plan

  assert {
    condition = local.key_vault == format(
      "%s-%s-%s%s",
      local.key_vault_config.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME,
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "key-vault naming convention is incorrect"
  }
}
