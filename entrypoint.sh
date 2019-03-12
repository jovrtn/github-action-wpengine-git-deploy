#!/bin/sh -l

set -e

: ${WPENGINE_SITE?Required environment variable not set.}

SSH_PATH="$HOME/.ssh"
WPENGINE_HOST="git.wpengine.com"
KNOWN_HOSTS="$SSH_PATH/known_hosts"
DEPLOY_KEY="$SSH_PATH/deploy_key"
DEPLOY_KEY_PUB="$SSH_PATH/deploy_key.pub"
WPENGINE_ENVIRONMENT_DEFAULT="production"
WPENGINE_ENV=${WPENGINE_ENVIRONMENT:-$WPENGINE_ENVIRONMENT_DEFAULT}

ssh-keyscan -t rsa "$WPENGINE_HOST" >> "$KNOWN_HOSTS"

echo "$WPENGINE_PRIVATE_KEY" > "$DEPLOY_KEY"
echo "$WPENGINE_PUBLIC_KEY" > "$DEPLOY_KEY_PUB"

chmod 700 "$SSH_PATH"
chmod 644 "$KNOWN_HOSTS_PATH"
chmod 600 "$DEPLOY_KEY"
chmod 644 "$DEPLOY_KEY_PUB"

git config core.sshCommand "ssh -i $SSH_PATH/deploy_key -o UserKnownHostsFile=$KNOWN_HOSTS"
git remote add $WPENGINE_ENV git@$WPENGINE_HOST:$WPENGINE_ENV/$WPENGINE_SITE.git
git push -f $WPENGINE_ENV master
