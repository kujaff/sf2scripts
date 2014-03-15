#!/bin/bash

source vendor/kujaff/sf2scripts/functions.sh

title "Delete caches"

execCmd "sudo rm -rf app/cache/*"
execCmd "sudo chmod -R 777 app/cache"

echoOk
exit 0