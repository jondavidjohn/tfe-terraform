# my-tfe

Clone this repo to your local machine.

## Setup Vars
```sh
cp terraform.tfvars.example terraform.tfvars
```

You may want to customize the fields to your liking, e.g.:
pointing to your repo, working directory, etc.

It might also behoove you to edit main.tf as well, e.g.:
changing the workspace name, number of created workspaces, etc.

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

### Api Token
In TFE UI go to User Settings -> Tokens and create a new API token.
This will go into your ~/.terraformrc file:

```sh
# tfe:local
credentials "tfe-zone-***.ngrok.io" {
  token = "<TFC-ADMIN-TOKEN>"
}
```


## Usage
After nuking, you will need to create a new API token in the TFE UI and set it
up properly with a [terraform credentials file](https://www.terraform.io/docs/commands/cli-config.html#available-settings). In the future, we may be able
to write a script to handle this automatically.

I personally setup branches for each environment I regularly use like:
* prod/duckduck
* prod/duckduck-with-queue-manager
* oasis/duckduck
* local/duckduck
* ...
