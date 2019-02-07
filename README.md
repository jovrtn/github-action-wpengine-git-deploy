# GitHub Action for WP Engine Deployments

A basic action to deploy to a [WP Engine](https://wpengine.com) production site via git.

** !!! FOR TESTING PURPOSES ONLY -- DO NOT USE FOR PRODUCTION !!!**

## Example workflow

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
