resource "tfe_workspace" "teams_workspace" {
  organization      = var.organization_name
  name              = "teams"
}

resource "tfe_team" "visible_teams" {
  count        = 50
  name         = "team-${count.index}"
  organization = var.organization_name
  visibility   = "organization"
}

resource "tfe_team" "secret_team" {
  name         = "secret-team"
  organization = var.organization_name
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
  for_each                   = toset([for team in tfe_team.visible_teams : team.id])
  team_id                    = each.value
  organization_membership_id = data.tfe_organization_membership.user.id
}

resource "tfe_team_organization_member" "secret_team_user_membership" {
  team_id                    = tfe_team.secret_team.id
  organization_membership_id = data.tfe_organization_membership.user.id
}
