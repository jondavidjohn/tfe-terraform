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

resource "tfe_team" "visible_team" {
  count        = 15
  name         = "team-${count.index}"
  organization = "hashicorp"
  visibility   = "organization"
}

resource "tfe_team" "secret_team" {
  name         = "secret-team"
  organization = "hashicorp"
}

resource "tfe_team_access" "team_workspace_access" {
  for_each     = toset([for team in tfe_team.visible_team : team.id])
  team_id      = each.value
  access       = "read"
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_team_access" "secret_team_workspace_access" {
  access       = "read"
  team_id      = tfe_team.secret_team.id
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_team_organization_member" "visible_team_user_membership" {
  for_each                   = toset([for team in tfe_team.visible_team : team.id])
  team_id                    = each.value
  organization_membership_id = data.tfe_organization_membership.user.id
}

resource "tfe_team_organization_member" "visible_team_admin_membership" {
  for_each                   = toset([for team in tfe_team.visible_team : team.id])
  team_id                    = each.value
  organization_membership_id = data.tfe_organization_membership.admin.id
}

resource "tfe_team_organization_member" "secret_team_admin_membership" {
  team_id                    = tfe_team.secret_team.id
  organization_membership_id = data.tfe_organization_membership.admin.id
}
