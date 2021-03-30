provider "tfe" {
  hostname = var.hostname
  version  = "~> 0.23.0"
}

data "tfe_organization_membership" "admin" {
  organization  = "hashicorp"
  email = "admin@hashicorp.com"
}

data "tfe_organization_membership" "user" {
  organization  = "hashicorp"
  email = var.user_email
}

resource "tfe_oauth_client" "oauth" {
  organization     = "hashicorp"
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_oauth_token
  service_provider = "github"
}

resource "tfe_workspace" "workspace" {
  organization      = "hashicorp"
  name              = var.working_directory
  auto_apply        = true
  queue_all_runs    = true
  working_directory = var.working_directory

  vcs_repo {
    identifier     = var.repo
    branch         = var.branch
    oauth_token_id = tfe_oauth_client.oauth.oauth_token_id
  }
}
