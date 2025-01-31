run "private-dns-resolver" {
  command = plan

  assert {
    condition = local.private_dns_resolver == format(
      "%s-%s",
      local.private_dns_resolver_config.abbrev,
      var.PROJECT_KEY,
    )
    error_message = "private-dns-resolver naming convention is incorrect"
  }

  assert {
    condition = local.private_dns_resolver_inbound == format(
      "%s-%s",
      local.private_dns_resolver_inbound_config.abbrev,
      var.PROJECT_KEY,
    )
    error_message = "private-dns-resolver-inbound naming convention is incorrect"
  }

  assert {
    condition = local.private_dns_resolver_outbound == format(
      "%s-%s",
      local.private_dns_resolver_outbound_config.abbrev,
      var.PROJECT_KEY,
    )
    error_message = "private-dns-resolver-outbound naming convention is incorrect"
  }

}
