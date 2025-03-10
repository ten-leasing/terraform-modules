run "public_ip" {
  command = plan

  assert {
    condition = local.public_ip.name == format(
      "%s-%s%s%s",
      local.public_ip.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "public ip naming convention is incorrect"
  }
}
