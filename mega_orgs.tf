locals {
  one_thousand_workspaces = {for t in tfe_workspace.one_thousand: index(tfe_workspace.one_thousand, t) => t.id}
  five_thousand_workspaces = {for t in tfe_workspace.five_thousand: index(tfe_workspace.five_thousand, t) => t.id}
  ten_thousand_workspaces = {for t in tfe_workspace.ten_thousand: index(tfe_workspace.ten_thousand, t) => t.id}
}


// Organization with 1000 workspaces and a few vars per workspace
//
resource "tfe_organization" "one_thousand" {
  name  = "1k-org"
  email = var.user_email
}

resource "tfe_organization_membership" "one_thousand" {
  organization = tfe_organization.one_thousand.name
  email        = var.user_email
}

resource "tfe_workspace" "one_thousand" {
  count        = 1000
  organization = tfe_organization.one_thousand.name
  name         = "workspace-${count.index}"
}

resource "tfe_variable" "one_thousand_a" {
  for_each     = local.one_thousand_workspaces
  key          = "workspace_var_a"
  value        = "some_workspace_value"
  category     = "terraform"
  workspace_id = each.value
  description  = "workspace defined variable"
}

resource "tfe_variable" "one_thousand_b" {
  for_each     = local.one_thousand_workspaces
  key          = "workspace_var_b"
  value        = "some_workspace_value"
  category     = "terraform"
  workspace_id = each.value
  description  = "workspace defined variable"
}

// Organization with 5000 workspaces and a few vars per workspace
//
resource "tfe_organization" "five_thousand" {
  name  = "5k-org"
  email = var.user_email
}

resource "tfe_organization_membership" "five_thousand" {
  organization = tfe_organization.five_thousand.name
  email        = var.user_email
}

resource "tfe_workspace" "five_thousand" {
  count        = 10000
  organization = tfe_organization.five_thousand.name
  name         = "workspace-${count.index}"
}

resource "tfe_variable" "five_thousand_a" {
  for_each     = local.five_thousand_workspaces
  key          = "workspace_var_a"
  value        = "some_workspace_value"
  category     = "terraform"
  workspace_id = each.value
  description  = "workspace defined variable"
}

resource "tfe_variable" "five_thousand_b" {
  for_each     = local.five_thousand_workspaces
  key          = "workspace_var_b"
  value        = "some_workspace_value"
  category     = "terraform"
  workspace_id = each.value
  description  = "workspace defined variable"
}

// Organization with 10000 workspaces and a few vars per workspace
//
resource "tfe_organization" "ten_thousand" {
  name  = "10k-org"
  email = var.user_email
}

resource "tfe_organization_membership" "ten_thousand" {
  organization = tfe_organization.ten_thousand.name
  email        = var.user_email
}

resource "tfe_workspace" "ten_thousand" {
  count        = 1000
  organization = tfe_organization.ten_thousand.name
  name         = "workspace-${count.index}"
}

resource "tfe_variable" "ten_thousand_a" {
  for_each     = local.ten_thousand_workspaces
  key          = "workspace_var_a"
  value        = "some_workspace_value"
  category     = "terraform"
  workspace_id = each.value
  description  = "workspace defined variable"
}

resource "tfe_variable" "ten_thousand_b" {
  for_each     = local.ten_thousand_workspaces
  key          = "workspace_var_b"
  value        = "some_workspace_value"
  category     = "terraform"
  workspace_id = each.value
  description  = "workspace defined variable"
}
