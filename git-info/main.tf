locals {
  git_config_path     = "${path.cwd}/.git/config"
  git_remote_urls_set = var.git_remote_urls != []
  git_config_content  = fileexists(local.git_config_path) ? file("${local.git_config_path}") : ""

  remotes = compact(
    compact(var.git_remote_urls),
    regexall("\\[remote (?:\"(?P<name>.*)\"\\]\\n.*url.*=.*(?P<url>https.*))", local.git_config_content),
  )
}

variable "git_remote_urls" {
  type = list(string)
}

output "remotes" {
  value = { for remote in local.remotes : replace(remote.name, "azure", "az") => remote.url }
}
