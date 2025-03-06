run "function-app" {
  command = plan

  assert {
    condition = local.function_app.name == format(
      "%s-%s-%s%s",
      local.function_app.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME,
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "function-app naming convention is incorrect"
  }
}
