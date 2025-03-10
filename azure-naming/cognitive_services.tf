locals {
  open_ai_abbreviation = "oai"
  open_ai = {
    abbrev = local.open_ai_abbreviation
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s-%s%s%s",
      local.open_ai_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }

  translator_abbreviation = "trsl"
  translator = {
    abbrev = local.translator_abbreviation
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s-%s%s%s",
      local.translator_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "open_ai" { value = local.open_ai }
output "translator" { value = local.translator }
