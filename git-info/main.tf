locals {
  git_config_path    = "${path.cwd}/.git/config"
  git_config_content = fileexists(local.git_config_path) ? file("${local.git_config_path}") : ""

  remotes = flatten(concat(
    regexall("\\[remote (?:\"(?P<name>.*)\"\\]\\n.*url.*=.*(?P<url>https.*))", local.git_config_content),
    var.git_remote_urls
  ))
}

variable "git_remote_urls" {
  type    = list(object({ name = string, url = string }))
  default = []
}

output "remotes" {
  value = { for remote in local.remotes : replace(remote.name, "azure", "az") => remote.url }
}
