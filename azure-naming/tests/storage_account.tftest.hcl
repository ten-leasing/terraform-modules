run "storage-account" {
  command = plan

  assert {
    condition = local.storage_account == format(
      "%s%s%s%s",
      local.storage_account_config.abbrev,
      var.ORG_KEY,
      var.PROJECT_KEY,
      var.WORKSPACE == "default" ? "" : "${var.WORKSPACE}"
    )
    error_message = "storage-account naming convention is incorrect"
  }
}
