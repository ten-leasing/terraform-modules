locals {
  web_pubsub_abbreviation = "wps"
  web_pubsub = {
    abbrev = local.web_pubsub_abbreviation
    scope  = local.scopes.global
    parent = local.resource_group
    name = format(
      "%s-%s%s%s",
      local.web_pubsub_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "web_pubsub" { value = local.web_pubsub }
