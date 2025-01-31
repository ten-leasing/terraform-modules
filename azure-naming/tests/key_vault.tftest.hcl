run "key-vault" {
  command = plan

  assert {
    condition = local.key_vault == format(
      "%s-%s",
      local.key_vault_config.abbrev,
      var.PROJECT_KEY,
    )
    error_message = "key-vault naming convention is incorrect"
  }
}
