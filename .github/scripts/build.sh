#!/bin/bash
set -ex

build=$1
env=""

[ $build = "enable" ] || exit 0
[ "$2" = "prod" ] || { env="-$2"; sed -i 's/production/staging/' apps/client/package.json apps/dashboard/package.json; }

docker build -t bandada-dashboard$env:latest -f apps/dashboard/Dockerfile .
docker tag bandada-dashboard$env:latest 490752553772.dkr.ecr.eu-central-1.amazonaws.com/bandada-dashboard$env:latest
docker push 490752553772.dkr.ecr.eu-central-1.amazonaws.com/bandada-dashboard$env:latest

exit 0
