#!/bin/bash

source vendor/kujaff/sf2scripts/functions.sh

title "Update database"
execConsole "doctrine:schema:update --force"

echoOk
exit 0