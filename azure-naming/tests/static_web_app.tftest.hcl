run "static-web-app" {
  command = plan

  assert {
    condition = local.static_web_app == format(
      "%s-%s-%s%s",
      local.static_web_app_config.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME,
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "static-web-app naming convention is incorrect"
  }
}
