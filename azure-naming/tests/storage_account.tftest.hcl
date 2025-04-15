run "storage-account" {
  command = plan

  assert {
    condition = local.storage_account.name == replace(
      format(
        "%s%s%s%s",
        local.storage_account.abbrev,
        var.ORG_KEY,
        var.RESOURCE_NAME,
        var.WORKSPACE == "default" ? "" : "${var.WORKSPACE}"
      ), "-", ""
    )
    error_message = "storage-account naming convention is incorrect"
  }
}
