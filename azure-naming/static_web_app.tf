locals {
  static_web_app_abbreviation = "stapp"
  static_web_app = {
    abbrev = local.static_web_app_abbreviation
    scope  = local.scopes.global
    parent = local.resource_group
    name = format(
      "%s-%s%s%s",
      local.static_web_app_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "static_web_app" { value = local.static_web_app }
