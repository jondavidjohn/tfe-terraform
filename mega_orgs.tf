 locals {
#   one_thousand_workspaces = {for t in tfe_workspace.random_workspace_1k: index(tfe_workspace.random_workspace_1k, t) => t.id}
#   five_thousand_workspaces = {for t in tfe_workspace.five_thousand: index(tfe_workspace.five_thousand, t) => t.id}
#   ten_thousand_workspaces = {for t in tfe_workspace.ten_thousand: index(tfe_workspace.ten_thousand, t) => t.id}
 }


// Organization with 1000 workspaces and a few vars per workspace
//
#resource "tfe_organization" "one_thousand" {
#  name  = "1k-org"
#  email = var.user_email
#}
#
#resource "tfe_organization_membership" "one_thousand" {
#  organization = tfe_organization.one_thousand.name
#  email        = var.user_email
#}
#
#resource "tfe_oauth_client" "oauth_1k" {
#  organization     = tfe_organization.one_thousand.name
#  api_url          = "https://api.github.com"
#  http_url         = "https://github.com"
#  oauth_token      = var.github_oauth_token
#  service_provider = "github"
#}
#
#resource "tfe_workspace" "random_workspace_1k" {
#  count             = 250
#  organization      = tfe_organization.one_thousand.name
#  name              = "1k-workspace-${count.index}-random"
#  auto_apply        = true
#  queue_all_runs    = true
#  working_directory = "./random"
#
#  vcs_repo {
#    identifier     = var.repo
#    branch         = var.branch
#    oauth_token_id = tfe_oauth_client.oauth_1k.oauth_token_id
#  }
#}
#
# resource "tfe_variable" "one_thousand_a" {
#   for_each     = local.one_thousand_workspaces
#   key          = "workspace_var_a"
#   value        = "some_workspace_value"
#   category     = "terraform"
#   workspace_id = each.value
#   description  = "workspace defined variable"
# }
# 
# resource "tfe_variable" "one_thousand_b" {
#   for_each     = local.one_thousand_workspaces
#   key          = "workspace_var_b"
#   value        = "some_workspace_value"
#   category     = "terraform"
#   workspace_id = each.value
#   description  = "workspace defined variable"
# }
# 
# // Organization with 5000 workspaces and a few vars per workspace
# //
# resource "tfe_organization" "five_thousand" {
#   name  = "5k-org"
#   email = var.user_email
# }
# 
# resource "tfe_organization_membership" "five_thousand" {
#   organization = tfe_organization.five_thousand.name
#   email        = var.user_email
# }
# 
# resource "tfe_workspace" "five_thousand" {
#   count        = 10000
#   organization = tfe_organization.five_thousand.name
#   name         = "workspace-${count.index}"
# }
# 
# resource "tfe_variable" "five_thousand_a" {
#   for_each     = local.five_thousand_workspaces
#   key          = "workspace_var_a"
#   value        = "some_workspace_value"
#   category     = "terraform"
#   workspace_id = each.value
#   description  = "workspace defined variable"
# }
# 
# resource "tfe_variable" "five_thousand_b" {
#   for_each     = local.five_thousand_workspaces
#   key          = "workspace_var_b"
#   value        = "some_workspace_value"
#   category     = "terraform"
#   workspace_id = each.value
#   description  = "workspace defined variable"
# }
# 
# // Organization with 10000 workspaces and a few vars per workspace
# //
# resource "tfe_organization" "ten_thousand" {
#   name  = "10k-org"
#   email = var.user_email
# }
# 
# resource "tfe_organization_membership" "ten_thousand" {
#   organization = tfe_organization.ten_thousand.name
#   email        = var.user_email
# }
# 
# resource "tfe_workspace" "ten_thousand" {
#   count        = 1000
#   organization = tfe_organization.ten_thousand.name
#   name         = "workspace-${count.index}"
# }
# 
# resource "tfe_variable" "ten_thousand_a" {
#   for_each     = local.ten_thousand_workspaces
#   key          = "workspace_var_a"
#   value        = "some_workspace_value"
#   category     = "terraform"
#   workspace_id = each.value
#   description  = "workspace defined variable"
# }
# 
# resource "tfe_variable" "ten_thousand_b" {
#   for_each     = local.ten_thousand_workspaces
#   key          = "workspace_var_b"
#   value        = "some_workspace_value"
#   category     = "terraform"
#   workspace_id = each.value
#   description  = "workspace defined variable"
# }
