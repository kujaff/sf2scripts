#!/bin/bash

source vendor/kujaff/sf2scripts/functions.sh

#####################
# vidage des caches #
#####################

execCmdNoEcho "./vendor/kujaff/sf2scripts/cache.sh $sf2env"

###############################
# mise à jour de la structure #
###############################

title "Mise à jour de la base de donnees"
execConsole "doctrine:schema:update --force"

echoOk
exit 0