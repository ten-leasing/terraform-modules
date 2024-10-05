variable "VARIABLES" {
  type     = map(string)
  nullable = true
  default  = null
}

resource "github_actions_environment_variable" "variables" {
  for_each = var.VARIABLES == null ? {} : var.VARIABLES

  repository  = github_repository_environment.self.repository
  environment = github_repository_environment.self.environment

  variable_name = each.key
  value         = each.value
}
