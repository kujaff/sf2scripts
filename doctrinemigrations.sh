#!/bin/bash

source vendor/kujaff/sf2scripts/functions.sh

title "Doctrine migrations"
exVerbose=$verbose
verbose="v"
execCmd "php app/console doctrine:migrations:migrate"
verbose=$exVerbose

echoOk
exit 0