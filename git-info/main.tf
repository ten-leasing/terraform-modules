data "external" "remote" {
  program = ["git", "remote", "-vv"]
}

output "git_remote" {
  value = data.external.remote.result
}
