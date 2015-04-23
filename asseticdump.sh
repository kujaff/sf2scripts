#!/bin/bash

source vendor/kujaff/sf2scripts/functions.sh

title "Assetic dump"
if [ "$verbose" = "v" ]; then
    execCmd "php app/console assetic:dump --env=$sf2env"
else
    execCmd "php app/console assetic:dump --env=$sf2env --no-debug"
fi

echoOk
exit 0