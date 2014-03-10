#!/bin/bash

source vendor/kujaff/sf2scripts/functions.sh

noDev=""
if [ "$sf2env" = "prod" ]; then
    noDev=" --no-dev"
fi
title "Update composer dependencies"
execCmd "composer update$noDev"

echoOk
exit 0