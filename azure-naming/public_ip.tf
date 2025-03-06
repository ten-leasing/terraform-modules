locals {
  public_ip_abbreviation = "pip"
  public_ip = {
    abbrev = local.public_ip_abbreviation
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s-%s-%s",
      local.public_ip_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME,
    )
  }
}

output "public_ip" { value = local.public_ip }
