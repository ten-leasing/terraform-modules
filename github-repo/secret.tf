variable "SECRETS" {
  type      = map(string)
  nullable  = true
  default   = null
  sensitive = true
}

resource "github_actions_secret" "secrets" {
  for_each = nonsensitive(var.SECRETS) == null ? {} : nonsensitive(var.SECRETS)

  repository = github_repository.self.name

  secret_name     = each.key
  plaintext_value = each.value
}
