variable "NAME" { type = string }
variable "DESCRIPTION" { type = string }

variable "ENABLE_ISSUES" {
  type    = bool
  default = false
}

resource "github_repository" "self" {
  name        = var.NAME
  description = var.DESCRIPTION

  visibility                  = "internal"
  web_commit_signoff_required = true
  vulnerability_alerts        = true
  has_downloads               = false
  delete_branch_on_merge      = true
  allow_update_branch         = true
  allow_squash_merge          = true
  allow_rebase_merge          = true
  allow_merge_commit          = false
  allow_auto_merge            = true
  has_discussions             = false
  has_issues                  = var.ENABLE_ISSUES
  has_projects                = false
  has_wiki                    = false
}

output "github_repository" { value = github_repository.self }
