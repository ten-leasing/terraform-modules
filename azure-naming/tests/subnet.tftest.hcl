run "subnet" {
  command = plan

  assert {
    condition = local.subnet == format(
      "%s-%s",
      local.subnet_config.abbrev,
      var.RESOURCE_NAME,
    )
    error_message = "subnet naming convention is incorrect"
  }
}
