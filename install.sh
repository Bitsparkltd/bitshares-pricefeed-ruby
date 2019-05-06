#!/bin/bash

set -e

mkdir -p ./../shared/price_feed/log
mkdir -p ./../shared/price_feed/bundle

cp .env.example .env
cp docker.yml.example docker.yml

exec "$@"
