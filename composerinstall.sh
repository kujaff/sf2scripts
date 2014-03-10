#!/bin/bash

source vendor/kujaff/sf2scripts/functions.sh

noDev=""
if [ "$sf2env" = "prod" ]; then
    noDev=" --no-dev"
fi
title "Install composer dependencies"
execCmd "composer install$noDev"

echoOk
exit 0