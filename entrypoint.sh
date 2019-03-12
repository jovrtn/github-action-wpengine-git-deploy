#!/bin/sh -l

set -e

: ${WPENGINE_SITE?Required environment variable not set.}
: ${WPENGINE_SSH_KEY_PRIVATE?Required secret not set.}
: ${WPENGINE_SSH_KEY_PUBLIC?Required secret not set.}

SSH_PATH="$HOME/.ssh"
WPENGINE_HOST="git.wpengine.com"
KNOWN_HOSTS="$SSH_PATH/known_hosts"
WPENGINE_SSH_KEY_PRIVATE="$SSH_PATH/wpengine_key"
WPENGINE_SSH_KEY_PUBLIC="$SSH_PATH/wpengine_key.pub"
WPENGINE_ENVIRONMENT_DEFAULT="production"
WPENGINE_ENV=${WPENGINE_ENVIRONMENT:-$WPENGINE_ENVIRONMENT_DEFAULT}

mkdir "$SSH_PATH"

ssh-keyscan -t rsa "$WPENGINE_HOST" >> "$KNOWN_HOSTS"

echo "$WPENGINE_PRIVATE_KEY" > "$SSH_$DEPLOY_KEY"
echo "$WPENGINE_PUBLIC_KEY" > "$SSH_DEPLOY_KEY_PUB"

chmod 700 "$SSH_PATH"
chmod 644 "$KNOWN_HOSTS"
chmod 600 "$DEPLOY_KEY"
chmod 644 "$DEPLOY_KEY_PUB"

git config core.sshCommand "ssh -i $SSH_$DEPLOY_KEY -o UserKnownHostsFile=$KNOWN_HOSTS"
git remote add $WPENGINE_ENV git@$WPENGINE_HOST:$WPENGINE_ENV/$WPENGINE_SITE.git
git push -f $WPENGINE_ENV master
