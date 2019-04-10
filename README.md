# GitHub Action for WP Engine Git Deployments

An action to deploy your repository to a **[WP Engine](https://wpengine.com)** site via git. [Read more](https://wpengine.com/git/) about WP Engine's git deployment support.

## Example GitHub Action workflow

```
workflow "Deploy to WP Engine" {
  on = "push"
  resolves = ["Git Push to Production"]
}

action "Git Push to Production" {
  uses = "jovrtn/github-action-wpengine-deploy@master"
  env = {
    WPENGINE_ENVIRONMENT_NAME   = "my-cool-site-production"
  }
  secrets = [
    "WPENGINE_SSH_KEY_PRIVATE",
    "WPENGINE_SSH_KEY_PUBLIC"
  ]
}
```

## Environment Variables & Secrets

### Required

| Name | Type | Usage |
|-|-|-|
| `WPENGINE_ENVIRONMENT_NAME` | Environment Variable | The name of the WP Engine environment you want to deploy to. |
| `WPENGINE_SSH_KEY_PRIVATE` | Secret | Private SSH key of your WP Engine git deploy user. See below for SSH key usage. |
|  `WPENGINE_SSH_KEY_PUBLIC` | Secret | Public SSH key of your WP Engine git deploy user. See below for SSH key usage. |

### Optional

| Name | Type  | Usage |
|-|-|-|
| `WPENGINE_ENVIRONMENT` | Environment Variable  | Defaults to `production`. You shouldn't need to change this, but if you're using WP Engine's legacy staging, you can override the default and set to `staging` if needed. |

### Further reading

* [Defining environment variables in GitHub Actions](https://developer.github.com/actions/creating-github-actions/accessing-the-runtime-environment/#environment-variables)
* [Storing secrets in GitHub repositories](https://developer.github.com/actions/managing-workflows/storing-secrets/)

## Setting up your SSH keys

1. [Generate a new SSH key pair](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) as a special deploy key. The simplest method is to generate a key pair with a blank passphrase, which creates an unencrypted private key.
2. Store your public and private keys in your GitHub repository as new 'Secrets' (under your repository settings), using the names `WPENGINE_SSH_KEY_PRIVATE` and `WPENGINE_SSH_KEY_PUBLIC` respectively. In theory, this replaces the need for encryption on the key itself, since GitHub repository secrets are encrypted by default.
3. Add the public key to your WP Engine production environment.
4. Per the [WP Engine documentation](https://wpengine.com/git/), it takes about 30-45 minutes for the new SSH key to become active.
