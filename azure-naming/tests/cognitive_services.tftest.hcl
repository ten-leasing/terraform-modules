run "open-ai" {
  command = plan

  assert {
    condition = local.open_ai.name == format(
      "%s-%s%s",
      local.open_ai.abbrev,
      var.ORG_KEY,
      var.WORKSPACE == "default" ? "" : "-${var.RESOURCE_NAME}",
    )
    error_message = "open-ai naming convention is incorrect"
  }

  assert {
    condition = local.translator.name == format(
      "%s-%s%s",
      local.translator.abbrev,
      var.ORG_KEY,
      var.WORKSPACE == "default" ? "" : "-${var.RESOURCE_NAME}",
    )
    error_message = "translator naming convention is incorrect"
  }
}
