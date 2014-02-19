#!/bin/bash

source vendor/kujaff/sf2scripts/functions.sh

#########################
# Suppression et droits #
#########################

title "Suppression des caches"

execCmd "sudo rm -rf app/cache/*"
execCmd "sudo chmod -R 777 app/cache"

if [ "$sf2env" = "prod" ]; then
    execConsole "assetic:dump --env=prod"
    execCmd "sudo rm -rf app/cache/*"
    execCmd "sudo chmod -R 777 app/cache"
else
    execCmd "sudo rm -rf web/js"
    execCmd "sudo rm -rf web/css"
fi

execCmd "sudo chmod -R 777 app/cache"

echoOk
exit 0
