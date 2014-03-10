#!/bin/bash

source vendor/kujaff/sf2scripts/functions.sh

title "Create dirs and set credentials"
createDir777 app/cache
createDir777 app/logs

echoOk
exit 0