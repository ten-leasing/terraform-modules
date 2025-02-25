run "public_ip" {
  command = plan

  assert {
    condition = local.public_ip == format(
      "%s-%s-%s",
      local.public_ip_config.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME,
    )
    error_message = "public ip naming convention is incorrect"
  }
}
