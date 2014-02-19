#!/bin/bash

source scripts/functions.sh

################################################
# Confirmation si on est sur master ou develop #
################################################

if [ "$(getGitBranch)" = "develop" ] || [ "$(getGitBranch)" = "master" ]; then
    echo -en "\033[41m\033[1;37m  "
    echo -en "/!\ ATTENTION /!\ Branche $(getGitBranch) /!\ \n"
    echo -en "  Etes-vous sûr de vouloir mettre à jour la branche $(getGitBranch) ? (y/n) "
    read confirm
    if [ "$confirm" != "y" ]; then
        echo -en "\033[0m"
        cancelScript
    fi
    echo -en "\033[0m\n\n"

    if [ "$1" = "" ]; then
        echo -en "\033[41m\033[1;37m  "
        echo -en "/!\ ATTENTION /!\ Branche $(getGitBranch) /!\ \n"
        echo -en "  Quel est l'environnement ? (\033[42m\033[1;37mprod\033[41m\033[1;37m/dev) "
        read sf2env
        if [ "$sf2env" = "" ]; then
            sf2env="prod"
        fi
        echo -en "\033[0m\n\n"
    fi
fi

##############################
# Vérification normes de dev #
##############################

if [ "$sf2env" != "prod" ]; then
    execCmdNoEcho "./scripts/csfixer.sh"
fi

################################################
# création des répertoires / liens symboliques #
################################################

title "Creation des repertoires et droits"
createDir777 app/cache
createDir777 app/logs
echoOk

############
# git pull #
############

title "Mise à jour de $(getGitBranch)"
execCmd "git pull"
echoOk

####################
# composer install #
####################

noDev=""
if [ "$sf2env" = "prod" ]; then
    noDev=" --no-dev"
fi
title "Installation des dependances"
execCmd "composer install$noDev"
echoOk

##################################
# doctrine:schema:update --force #
##################################

execCmdNoEcho "./scripts/schema.sh $sf2env"

###################################
# doctrine:fixtures:load --append #
###################################

#title "Donnees dans la base"
#execCmd "sudo -u www-data php app/console --env=$sf2env doctrine:fixtures:load --append"
#echoOk

#######
# fin #
#######

block 42 "Mise à jour terminée"