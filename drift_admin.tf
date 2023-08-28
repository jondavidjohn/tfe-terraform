resource "tfe_workspace" "drift_admin_workspace" {
  organization        = var.organization_name
  name                = "drift-admin"
  auto_apply          = true
  queue_all_runs      = true
  assessments_enabled = true
  terraform_version   = "1.5.0"

  vcs_repo {
    identifier     = "jondavidjohn/drift-admin"
    branch         = "main"
    oauth_token_id = tfe_oauth_client.oauth.oauth_token_id
  }
}

resource "tfe_variable" "drift_admin_hostname" {
  key          = "hostname"
  value        = var.hostname
  category     = "terraform"
  workspace_id = tfe_workspace.drift_admin_workspace.id
  description  = "TFC hostname"
}

resource "tfe_variable" "drift_admin_org_name" {
  key          = "org_name"
  value        = var.organization_name
  category     = "terraform"
  workspace_id = tfe_workspace.drift_admin_workspace.id
  description  = "TFC organization name"
}

resource "tfe_variable" "drift_admin_tfe_token" {
  key          = "TFE_TOKEN"
  value        = var.tfe_token
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.drift_admin_workspace.id
  description  = "TFC organization name"
}
