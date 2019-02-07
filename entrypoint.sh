#!/bin/sh -l

set -e

mkdir "$HOME/.ssh"
SSH_PATH="$HOME/.ssh"
HOST="git.wpengine.com"

ssh-keyscan -t rsa $HOST >> "$SSH_PATH/known_hosts"

echo "$WPENGINE_PRIVATE_KEY" > "$SSH_PATH/deploy_key"
echo "$WPENGINE_PUBLIC_KEY" > "$SSH_PATH/deploy_key.pub"

chmod 700 "$SSH_PATH"
chmod 644 "$SSH_PATH/known_hosts"
chmod 600 "$SSH_PATH/deploy_key"
chmod 644 "$SSH_PATH/deploy_key.pub"

git config core.sshCommand "ssh -i $SSH_PATH/deploy_key -o UserKnownHostsFile=$SSH_PATH/known_hosts"
git remote add production git@git.wpengine.com:production/$WPE_PRODUCTION_NAME.git
git push -f production master
