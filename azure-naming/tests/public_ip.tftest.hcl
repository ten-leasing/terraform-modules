run "public_ip" {
  command = plan

  assert {
    condition = local.public_ip.name == format(
      "%s-%s%s",
      local.public_ip.abbrev,
      var.ORG_KEY,
      var.WORKSPACE == "default" ? "" : "-${var.RESOURCE_NAME}",
    )
    error_message = "public ip naming convention is incorrect"
  }
}
