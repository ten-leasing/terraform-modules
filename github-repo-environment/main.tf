variable "GITHUB_REPOSITORY_NAME" { type = string }
variable "NAME" { type = string }

variable "ADMIN_BYPASS" {
  type    = bool
  default = false
}
variable "PREVENT_SELF_REVIEW" {
  type    = bool
  default = true
}
variable "REVIEWERS" {
  type = object({
    teams = set(number)
    users = set(number)
  })
  default  = null
  nullable = true
}
variable "VARIABLES" {
  type     = map(string)
  nullable = true
  default  = null
}

resource "github_repository_environment" "self" {
  repository  = var.GITHUB_REPOSITORY_NAME
  environment = var.NAME

  can_admins_bypass   = var.ADMIN_BYPASS
  prevent_self_review = var.PREVENT_SELF_REVIEW

  dynamic "reviewers" {
    for_each = var.REVIEWERS == null ? [] : [var.REVIEWERS]

    content {
      teams = reviewers.value.teams == null ? [] : reviewers.value.teams
      users = reviewers.value.users == null ? [] : reviewers.value.users
    }
  }
}

output "github_repository_environment" { value = github_repository_environment.self }

resource "github_actions_environment_variable" "variables" {
  for_each = var.VARIABLES == null ? {} : var.VARIABLES

  repository  = github_repository_environment.self.repository
  environment = github_repository_environment.self.environment

  value         = each.value
  variable_name = each.key
}
