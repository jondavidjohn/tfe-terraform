# my-tfe

Clone this repo to your local machine.

## Setup Vars
```sh
cp terraform.tfvars.example terraform.tfvars
```

You may want to customize the fields to your liking, e.g.:
pointing to your repo, working directory, etc.

It might also behoove you to edit main.tf as well, e.g.:
change around the different resources you need or expect.

### Oauth Token
Go to github and create a [personal access token](https://github.com/settings/tokens/new)
with the `repo` and `admin:repo_hook` scopes. Use this generated value for your
`oauth_token` value in `terraform.tfvars`.

### Hostname
```
rake tfe:local:info
```
Use the hostname portion of the url returned in the above command as your
`hostname` value in `terraform.tfvars`.

### Admin API Token
In TFE UI go to User Settings -> Tokens and create a new API token.
This will go into your ~/.terraformrc file:

```sh
# tfe:local
credentials "tfe-zone-***.ngrok.io" {
  token = "<TFC-ADMIN-TOKEN>"
}
```

This is used by the terraform provider to authenticate.
