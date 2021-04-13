# my-tfe

Clone this repo to your local machine.

## Setup Vars
```sh
cp terraform.tfvars.example terraform.tfvars
```

You may want to customize the fields to your liking, e.g.:
pointing to your repo, working directory, etc.

It might also behoove you to edit `main.tf` as well, e.g.:
change around the different resources you need or expect.

### Oauth Token
Go to github and create a [personal access token](https://github.com/settings/tokens/new)
with the `repo` and `admin:repo_hook` scopes. Use this generated value for your
`oauth_token` value in `terraform.tfvars`.

### Hostname
```
rake tfe:local:info
```
Use the hostname portion (removing the `https://` etc..) of the url returned in the above command as your
`hostname` value in `terraform.tfvars`.

### TFC API Token

In the TFC UI go to your User Settings -> Tokens and create a new API token.

(The user this token belongs to should correspond with the specified user email in your `tfvars` file.)

This will go into your ~/.terraformrc file:

```sh
# tfe:local
credentials "tfe-zone-***.ngrok.io" {
  token = "<TFC-ADMIN-TOKEN>"
}
```

This is used by the terraform provider to authenticate, and all resources will be created by this user.

## First Run!

Because these configurations use `for_each`, we need to target a few of these collections with our first apply.

```
terraform apply \
  -target=tfe_team.visible_teams \
  -target=tfe_workspace.run_triggering_workspaces \
  -target=tfe_workspace.run_triggered_workspaces \
  -auto-approve
```

Once this completes, you can proceed to a normal `terraform apply` workflow.

## Using it in other environments

If you want to use the configuration you have created in other environments, you should use [terraform workspaces](https://www.terraform.io/docs/language/state/workspaces.html).

The simple way to get started with this is to create a new workspace

```sh
terraform workspace new oasis
```

Copy your existing `tfvars` file and update the `hostname` and `organization_name` (this organization must already be created).  I generally call my original `default.tfvars` and the new one `oasis.tfvars`.

Your new workspace provides a way to maintain state for a new environment separate from your existing usage with `tfe:local`.

So you should now be able to start fresh against staging.  The only caveat is now that you have multiple `tfvars` files, you must specify which one you want to use.

For example, with our first run:

```
terraform apply \
  -target=tfe_team.visible_teams \
  -target=tfe_workspace.run_triggering_workspaces \
  -target=tfe_workspace.run_triggered_workspaces \
  -var-file="oasis.tfvars"
```

And then

```
terraform apply -var-file="oasis.tfvars"
```

### Switching between workspaces

To switch back to your `tfe:local` workspace (default)

```
terraform workspace select default
terraform apply -var-file="default.tfvars"
```
