# GitHub Action for WP Engine Deployments

A basic action to deploy to a [WP Engine](https://wpengine.com) production site via git.

**!!! FOR TESTING PURPOSES ONLY -- DO NOT USE FOR PRODUCTION !!!**

## Example GitHub Action workflow

```
workflow "Deploy to Production" {
  on = "push"
  resolves = ["WP Engine Deploy"]
}

action "WP Engine Deploy" {
  uses = "jovrtn/github-action-wpengine-deploy@master"
  env = {
    WPE_PRODUCTION_NAME  = "<your-wpengine-site-name>"
  }
  secrets = [
    "WPENGINE_PRIVATE_KEY",
    "WPENGINE_PUBLIC_KEY"
  ]
}
```

## Setting up your SSH keys

1. [Generate a new SSH key pair](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) as a special deploy key. The simplest method is to generate a key pair with a blank passphrase, which creates an unencrypted private key.
2. Store your public and private keys in your GitHub repository as new 'Secrets' (under your repository settings), using the names `WPENGINE_PUBLIC_KEY` and `WPENGINE_PRIVATE_KEY` respectively. In theory, this replaces the need for encryption on the key itself, since GitHub repository secrets are encrypted by default.
3. Add the public key to your WP Engine production environment.
4. Per the [WP Engine documentation](https://wpengine.com/git/), it takes about 30-45 minutes for the new SSH key to become active.
