variable "GITHUB_REPOSITORY_NAME" { type = string }
variable "NAME" { type = string }

variable "VARIABLES" {
  type     = map(string)
  nullable = true
  default  = null
}

resource "github_repository_environment" "self" {
  repository  = var.GITHUB_REPOSITORY_NAME
  environment = var.NAME
}

output "github_repository_environment" { value = github_repository_environment.self }

resource "github_actions_environment_variable" "variables" {
  for_each = var.VARIABLES == null ? {} : var.VARIABLES

  repository  = github_repository_environment.self.repository
  environment = github_repository_environment.self.environment

  value         = each.value
  variable_name = each.key
}
