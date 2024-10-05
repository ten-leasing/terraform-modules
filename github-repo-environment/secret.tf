variable "SECRETS" {
  type      = map(string)
  nullable  = true
  default   = null
  sensitive = true
}

resource "github_actions_environment_secret" "secrets" {
  for_each = nonsensitive(var.SECRETS) == null ? {} : nonsensitive(var.SECRETS)

  repository  = github_repository_environment.self.repository
  environment = github_repository_environment.self.environment

  secret_name     = each.key
  plaintext_value = each.value
}
