locals {
  private_dns_resolver_abbreviation = "dnspr"
  private_dns_resolver = {
    abbrev = "dnspr"
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s-%s-%s",
      local.private_dns_resolver_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME,
    )
  }

  private_dns_resolver_inbound_abbreviation = "in"
  private_dns_resolver_inbound = {
    abbrev = local.private_dns_resolver_inbound_abbreviation
    scope  = local.scopes.parent
    parent = local.private_dns_resolver
    name = format(
      "%s-%s",
      local.private_dns_resolver_inbound_abbreviation,
      var.RESOURCE_NAME,
    )
  }

  private_dns_resolver_outbound_abbreviation = "out"
  private_dns_resolver_outbound = {
    abbrev = local.private_dns_resolver_outbound_abbreviation
    scope  = local.scopes.parent
    parent = local.private_dns_resolver
    name = format(
      "%s-%s",
      local.private_dns_resolver_outbound_abbreviation,
      var.RESOURCE_NAME,
    )
  }
}

output "private_dns_resolver" { value = local.private_dns_resolver }
output "private_dns_inbound" { value = local.private_dns_resolver_inbound }
output "private_dns_outbound" { value = local.private_dns_resolver_outbound }
