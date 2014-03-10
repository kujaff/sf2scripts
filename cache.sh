#!/bin/bash

source vendor/kujaff/sf2scripts/functions.sh

title "Delete caches"

execCmd "sudo rm -rf app/cache/*"
execCmd "sudo chmod -R 777 app/cache"

if [ "$sf2env" = "prod" ]; then
    execConsole "assetic:dump"
fi

echoOk
exit 0