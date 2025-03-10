run "static-web-app" {
  command = plan

  assert {
    condition = local.static_web_app.name == format(
      "%s-%s%s%s",
      local.static_web_app.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "static-web-app naming convention is incorrect"
  }
}
