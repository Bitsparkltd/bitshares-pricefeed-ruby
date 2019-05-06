#!/bin/bash

set -e
# Exit on fail

apt-get update
apt-get install --assume-yes apt-utils cron vim screen

cp /app/crontab /var/spool/cron/crontabs/root
chmod 0600 /var/spool/cron/crontabs/root

cd /app

gem install bundler -v '2.0.1'
bundle check || bundle install --binstubs="$BUNDLE_BIN"
# Ensure all gems installed. Add binstubs to bin which has been added to PATH in Dockerfile.

printenv | grep -v "no_proxy" >> /etc/environment

cron
# Start cron daemon

exec "$@"
# Finally call command issued to the docker service
