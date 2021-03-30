resource "tfe_workspace" "teams_workspace" {
  organization      = "hashicorp"
  name              = "teams"
  auto_apply        = true
  queue_all_runs    = true
  working_directory = var.working_directory

  vcs_repo {
    identifier     = var.repo
    branch         = var.branch
    oauth_token_id = tfe_oauth_client.oauth.oauth_token_id
  }
}

resource "tfe_team" "visible_teams" {
  count        = 50
  name         = "team-${count.index}"
  organization = "hashicorp"
  visibility   = "organization"
}

resource "tfe_team" "secret_team" {
  name         = "secret-team"
  organization = "hashicorp"
}

resource "tfe_team_access" "team_workspace_access" {
  for_each     = toset([for team in tfe_team.visible_teams : team.id])
  team_id      = each.value
  access       = "read"
  workspace_id = tfe_workspace.teams_workspace.id
}

resource "tfe_team_access" "secret_team_workspace_access" {
  access       = "read"
  team_id      = tfe_team.secret_team.id
  workspace_id = tfe_workspace.teams_workspace.id
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
