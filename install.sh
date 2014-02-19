#!/bin/bash

function block() {
    titleLength=${#2}
    echo -en "\n\033[$1m\033[1;37m    "
    for x in $(seq 1 $titleLength); do echo -en " "; done ;
    echo -en "\033[0m\n"

    echo -en "\033[$1m\033[1;37m  $2  \033[0m\n"
    echo -en "\033[$1m\033[1;37m    "
    for x in $(seq 1 $titleLength); do echo -en " "; done ;
    echo -en "\033[0m\n\n"
}

function title() {
    block 46 "$1"
}

function getGitBranch() {
    echo "$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/' -e 's/(//g' -e 's/)//g')"
}

function installCanceled() {
    echo -en "\n\n"
    block 41 "$1"
    exit 1
}

###############################
# Confirmation d'installation #
###############################

if [ "$1" != "dev" ] && [ "$1" != "prod" ]; then
    installCanceled "Le premier paramètre doit être 'dev' ou 'prod'"
fi
sf2env=$1

block 43 "Installation de LifeCycle"
echo "L'installation effectuera d'abord une mise à jour (via update.sh) puis l'installation."
echo -en "Etes-vous sûr de vouloir installer LifeCycle depuis la branche $(getGitBranch) ? (y/n) "
read confirm
if [ "$confirm" != "y" ]; then
    echo -en "\033[0m"
    installCanceled "Processus d'installation annulé"
fi
echo -en "\033[0m\n\n"

#############
# update.sh #
#############

./scripts/update.sh $sf2env
[ "$?" != "0" ] && installCanceled "Processus d'installation annulé"

##################################
# Installation de DynUsersBundle #
##################################

title "[Installation du bundle DynUsersBundle] php app/console --env=$sf2env dynusers:install"
sudo -u www-data php app/console --env=$sf2env dynusers:install
[ "$?" != "0" ] && installCanceled "Processus d'installation annulé"

###################################
# Installation de DashboardBundle #
###################################

title "[Installation du bundle DashboardBundle] php app/console --env=$sf2env dashboard:install"
sudo -u www-data php app/console --env=$sf2env dashboard:install
[ "$?" != "0" ] && installCanceled "Processus d'installation annulé"

######################################
# Installation de LocalizationBundle #
######################################

title "[Installation du bundle LocalizationBundle] php app/console --env=$sf2env localization:install"
sudo -u www-data php app/console --env=$sf2env localization:install
[ "$?" != "0" ] && installCanceled "Processus d'installation annulé"

############################
# Création du compte admin #
############################

title "[Création du compte admin]"
echo -en "Identifiant (\033[33madmin\033[0m) : "
read userName
if [ "$userName" = "" ]; then
    userName="admin"
fi
echo -en "Mot de passe : "
read -s password
if [ "$password" = "" ]; then
    installCanceled "Vous devez indiquer le mot de passe de l'admin."
fi
echo -en "\nConfirmation : "
read -s passwordConfirm
echo ""
if [ "$password" != "$passwordConfirm" ]; then
    installCanceled "Le mot de passe et sa confirmation sont différents."
fi
echo -en "E-mail : "
read email
if [ "$email" = "" ]; then
    installCanceled "Vous devez indiquer l'email."
fi

echo ""

echo "php app/console --env=$sf2env dynusers:add $userName ***** $email 1196 advcurr"
sudo -u www-data app/console --env=$sf2env dynusers:add $userName $password $email 1196 advcurr
[ "$?" != "0" ] && installCanceled "Processus d'installation annulé"

#########################
# Installation terminée #
#########################

block 42 "Installation terminée"