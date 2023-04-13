terraform {
  required_providers {
    tfe = {
      version  = "~> 0.43.0"
    }
  }
}

provider "tfe" {
  hostname = var.hostname
}

data "tfe_organization_membership" "user" {
  organization  = var.organization_name
  email = var.user_email
}

resource "tfe_oauth_client" "oauth" {
  organization     = var.organization_name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_oauth_token
  service_provider = "github"
}

resource "tfe_workspace" "random_workspace" {
  organization      = var.organization_name
  name              = "randomz"
  auto_apply        = true
  queue_all_runs    = true
  working_directory = "./random"

  vcs_repo {
    identifier     = var.repo
    branch         = var.branch
    oauth_token_id = tfe_oauth_client.oauth.oauth_token_id
  }
}

resource "tfe_workspace" "variable_dump_workspace" {
  organization      = var.organization_name
  name              = "variable_dump"
  auto_apply        = true
  queue_all_runs    = true
  working_directory = "./variables-dump"

  vcs_repo {
    identifier     = var.repo
    branch         = var.branch
    oauth_token_id = tfe_oauth_client.oauth.oauth_token_id
  }
}

resource "tfe_workspace" "variable_repro_workspace" {
  organization      = var.organization_name
  name              = "variable_repro"
  auto_apply        = true
  queue_all_runs    = true
  working_directory = "./variables-repro"

  vcs_repo {
    identifier     = var.repo
    branch         = var.branch
    oauth_token_id = tfe_oauth_client.oauth.oauth_token_id
  }
}

resource "tfe_workspace" "tagged_vcs" {
  organization      = var.organization_name
  name              = "tagged_vcs"
  auto_apply        = true
  queue_all_runs    = true
  working_directory = "./random"
  tag_names         = ["prod", "application", "useast1"]

  vcs_repo {
    identifier     = var.repo
    branch         = var.branch
    oauth_token_id = tfe_oauth_client.oauth.oauth_token_id
  }
}

resource "tfe_workspace" "tagged" {
  organization      = var.organization_name
  name              = "tagged"
  auto_apply        = true
  queue_all_runs    = true
  working_directory = "./random"
  tag_names         = ["dev", "infra", "useast1"]
}
