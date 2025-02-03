locals {
  web_pubsub_config = {
    abbrev = "wps"
    scope  = local.scopes.global
  }

  web_pubsub = format(
    "%s-%s-%s%s",
    local.web_pubsub_config.abbrev,
    var.ORG_KEY,
    var.RESOURCE_NAME,
    var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
  )
}

output "web_pubsub" { value = local.web_pubsub }
