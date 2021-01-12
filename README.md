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

### TFC Admin API Token
In TFE UI go to User Settings -> Tokens and create a new API token.
This will go into your ~/.terraformrc file:

```sh
# tfe:local
credentials "tfe-zone-***.ngrok.io" {
  token = "<TFC-ADMIN-TOKEN>"
}
```

This is used by the [terraform provider][terraform-provider] to authenticate.

## Planning and Applying

### Admin Email

Since the organization "hashicorp" is being used by default in `main.tf` the admin e-mail needs to stay `admin@hashicorp.com` despite it being used against your own tfe:local instance.

### Mass Team Creation

Since the teams are being iterated through further along in the configuration file the teams resource needs to be created first.
Fortunately this is easily possible by using terraform's [`-target` flag][target-flag]:

```sh
terraform apply -target=tfe_team.visible_team
```

Then a normal `terraform apply` can be executed after.


<!-- Reflinks -->
[target-flag]:https://www.terraform.io/docs/commands/plan.html#resource-targeting
[terraform-provider]:https://github.com/hashicorp/terraform-provider-tfe
