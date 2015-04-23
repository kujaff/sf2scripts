#!/bin/bash

source vendor/kujaff/sf2scripts/functions.sh

title "Install assets"
execCmd "php app/console assets:install --symlink"

echoOk
exit 0