variable "NAME" { type = string }
variable "DESCRIPTION" { type = string }

variable "AUTO_INIT" {
  type    = bool
  default = false
}

variable "ENABLE_ISSUES" {
  type    = bool
  default = false
}

variable "IS_TEMPLATE" {
  type    = bool
  default = false
}

variable "DEFAULT_BRANCH_NAME" {
  type    = string
  default = "default"
}

variable "RENAME_EXISTING_DEFAULT_BRANCH" {
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
  is_template                 = var.IS_TEMPLATE
  auto_init                   = var.AUTO_INIT

  lifecycle {
    ignore_changes = [homepage_url]
  }
}
output "github_repository" { value = github_repository.self }

resource "github_branch" "default" {
  branch     = var.DEFAULT_BRANCH_NAME
  repository = github_repository.self.name
}

resource "github_branch_default" "self" {
  repository = github_repository.self.name
  branch     = var.DEFAULT_BRANCH_NAME
  rename     = var.RENAME_EXISTING_DEFAULT_BRANCH
}
