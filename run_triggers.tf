locals {
  #  triggereds = {for t in tfe_workspace.run_triggered_workspaces: index(tfe_workspace.run_triggered_workspaces, t) => t.id}
  #  triggerings = {for t in tfe_workspace.run_triggering_workspaces: index(tfe_workspace.run_triggering_workspaces, t) => t.id}
}

## --- Sets up the "run-triggered" workspace where we only have other workspaces triggering runs
#
#resource "tfe_workspace" "run_triggered_workspace" {
#  organization      = var.organization_name
#  name              = "run-triggered"
#}
#
#resource "tfe_workspace" "run_triggering_workspaces" {
#  count = 16
#  organization      = var.organization_name
#  name              = "run-triggerings-${count.index}"
#}
#
#resource "tfe_run_trigger" "run_trigger_triggered" {
#  for_each      = local.triggerings
#  sourceable_id = each.value
#  workspace_id  = tfe_workspace.run_triggered_workspace.id
#}
#
## --- Sets up the "run-triggering" workspace where we only are triggering other workspaces
#
#resource "tfe_workspace" "run_triggering_workspace" {
#  organization      = var.organization_name
#  name              = "run-triggering"
#}
#
#resource "tfe_workspace" "run_triggered_workspaces" {
#  count = 16
#  organization      = var.organization_name
#  name              = "run-triggereds-${count.index}"
#}
#
#resource "tfe_run_trigger" "run_trigger_triggering" {
#  for_each      = local.triggereds
#  sourceable_id = tfe_workspace.run_triggering_workspace.id
#  workspace_id  = each.value
#}
#
## --- Sets up the "run-triggers" workspace where we have both inbound and outbound triggers.
#
#resource "tfe_workspace" "run_triggers_workspace" {
#  organization      = var.organization_name
#  name              = "run-triggers"
#}
#
#resource "tfe_workspace" "long_name_workspace" {
#  organization      = var.organization_name
#  name              = "this-is-an-unreasonbly-long-workspace-name-that-has-enough-characters-to-truncate"
#}
#
#resource "tfe_run_trigger" "run_trigger_long_name" {
#  sourceable_id = tfe_workspace.run_triggers_workspace.id
#  workspace_id  = tfe_workspace.long_name_workspace.id
#}
#
#resource "tfe_run_trigger" "run_trigger_both_a" {
#  for_each      = local.triggereds
#  sourceable_id = each.value
#  workspace_id  = tfe_workspace.run_triggers_workspace.id
#}
#
#resource "tfe_run_trigger" "run_trigger_both_b" {
#  for_each      = local.triggerings
#  sourceable_id = tfe_workspace.run_triggers_workspace.id
#  workspace_id  = each.value
#}
