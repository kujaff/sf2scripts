#!/bin/bash

source scripts/functions.sh

#####################
# vidage des caches #
#####################

execCmdNoEcho "./scripts/cache.sh $sf2env"

###############################
# mise à jour de la structure #
###############################

title "Mise à jour de la base de donnees"
execConsole "doctrine:schema:update --force"

echoOk
exit 0