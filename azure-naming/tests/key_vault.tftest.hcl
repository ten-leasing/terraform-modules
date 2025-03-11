run "key-vault" {
  command = plan

  assert {
    condition = local.key_vault.name == format(
      "%s-%s%s%s",
      local.key_vault.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "key-vault naming convention is incorrect"
  }

  assert {
    condition = local.key_vault_secret.name == format(
      "%s-%s%s%s",
      local.key_vault_secret.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "key-vault secret naming convention is incorrect"
  }

}
