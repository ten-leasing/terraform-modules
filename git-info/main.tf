locals {
  git_config_path    = "${var.git_dir == "" ? path.root : var.git_dir}/.git/config"
  git_config_content = file("${local.git_config_path}")

  remotes = regexall("\\[remote (?:\"(?P<name>.*)\"\\]\\n.*url.*=.*(?P<url>https.*))", local.git_config_content)
}

variable "git_dir" {
  type    = string
  default = ""
}

output "git_config_path" {
  value = local.git_config_path
}

output "git_config_content" {
  value = local.git_config_content
}

output "remotes" {
  value = { for remote in local.remotes : replace(remote.name, "azure", "az") => remote.url }
}
