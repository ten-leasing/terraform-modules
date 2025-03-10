run "web-pubsub" {
  command = plan

  assert {
    condition = local.web_pubsub.name == format(
      "%s-%s%s%s",
      local.web_pubsub.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "web-pubsub naming convention is incorrect"
  }
}
