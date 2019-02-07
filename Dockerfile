FROM debian:9.7-slim

LABEL "com.github.actions.name"="GitHub Action for WP Engine Deployments"
LABEL "com.github.actions.description"="Deploy to WP Engine via Git"
LABEL "com.github.actions.icon"="chevrons-right"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/jovrtn/github-action-wpengine-deploy"
LABEL "maintainer"="Jesse L.K. Overton <jesse@ovrtn.com>"

RUN apt-get update && apt-get install -y git

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
