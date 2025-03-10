run "open-ai" {
  command = plan

  assert {
    condition = local.open_ai.name == format(
      "%s-%s%s%s",
      local.open_ai.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "open-ai naming convention is incorrect"
  }

  assert {
    condition = local.translator.name == format(
      "%s-%s%s%s",
      local.translator.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "translator naming convention is incorrect"
  }
}
