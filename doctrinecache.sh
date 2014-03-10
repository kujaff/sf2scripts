#!/bin/bash

source vendor/kujaff/sf2scripts/functions.sh

title "Delete doctrine caches"

execConsole "doctrine:cache:clear-metadata"
execConsole "doctrine:cache:clear-query"
execConsole "doctrine:cache:clear-result"

echoOk
exit 0