# JFrog Training Labs

## Common Prerequisites

There are certain prerequisites which are common to most (or all) of the demos and labs:

### Xray

Ensure that Xray is enabled and working ("Xray" -> "Settings" -> "Advanced"/"Settings" -> "Xray Enabled").

### Environment Variables

> make sure [Enable Token Generation via API](https://jfrog.com/help/r/jfrog-platform-administration-documentation/hide-basic-authentication) is enabled

Generate an identity token by editing & running the following command in a command-line window :

```bash
# SAAS_DNS example : yann.jfrog.io
# SAAS_DNS variable will be used for pushing docker images
export JFROG_SAAS_DNS="<SAAS_DNS>"
export JFROG_SAAS_URL="https://$JFROG_SAAS_DNS"

curl -u '<USERNAME>:<PASSWORD>' -XPOST "$JFROG_SAAS_URL/access/api/v1/tokens" -d "scope=applied-permissions/user"

# Export the access token in an environment variable for convenience.
# Also, this environment variable is automatically used by the JFrog Terraform provider.
export JFROG_ACCESS_TOKEN=<your_access_token>

jf c add jfrog-saas --interactive=false --url=$JFROG_SAAS_URL --access-token=$JFROG_ACCESS_TOKEN
jf c use jfrog-saas
```

### OPTIONAL - IDE

1. Install Visual Studio Code.
2. Install the JFrog Extension.
3. Configure the JFrog Extension by having it connect to your JFrog environment.
   1. If you properly installed the CLI already, then your CLI profile should be automatically detected by the IDE extension
      and you will be prompted accordingly.
