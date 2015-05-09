#!/bin/bash

source vendor/kujaff/sf2scripts/functions.sh

title "Delete caches"

execCmd "sudo rm -rf app/cache/*"
createDir777 "app/cache"

echoOk
