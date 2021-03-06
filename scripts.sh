#!/bin/bash

source vendor/kujaff/sf2scripts/functions.sh

confirm="true"
scripts="dirs,cache,pull,composerinstall,schema"
endMessage="true"
for param in $*
do
    if [ ${param:0:9} = '-confirm=' ]; then
        confirm=${param:9}
    elif [ ${param:0:9} = '-scripts=' ]; then
        scripts=${param:9}
    elif [ ${param:0:13} = '-end-message=' ]; then
        endMessage=${param:13}
    fi
done

########################################
# Confirm if were are on master branch #
########################################

if [[ "$(getGitBranch)" = "master" && "$confirm" = "true" ]]; then
    echo -en "\033[41m\033[1;37m"
    echo ""
    echo -en "  /!\ WARNING /!\ Branch $(getGitBranch) /!\ \n"
    echo -en "  Do you really want to update '$(getGitBranch)' branch ? (y/n) "
    read confirm
    if [ "$confirm" != "y" ]; then
        echo -en "\033[0m"
        cancelScript
    fi
    echo -en "\033[0m\n\n"
fi

###################
# Execute scripts #
###################

arScripts=$(echo $scripts | tr "," "\n")
for script in $arScripts; do

    if [ "$script" = "phpcsfixer" ]; then
        execCmdNoEcho "./vendor/kujaff/sf2scripts/csfixer.sh"

    elif [ "$script" = "dirs" ]; then
        execCmdNoEcho "./vendor/kujaff/sf2scripts/dirs.sh -env=$sf2env -webserver-user=$webserverUser"

    elif [ "$script" = "cache" ]; then
        execCmdNoEcho "./vendor/kujaff/sf2scripts/cache.sh -env=$sf2env -webserver-user=$webserverUser"

    elif [ "$script" = "pull" ]; then
        execCmdNoEcho "./vendor/kujaff/sf2scripts/pull.sh -env=$sf2env -webserver-user=$webserverUser"

    elif [ "$script" = "composerinstall" ]; then
        execCmdNoEcho "./vendor/kujaff/sf2scripts/composerinstall.sh -env=$sf2env -webserver-user=$webserverUser"

    elif [ "$script" = "composersupdate" ]; then
        execCmdNoEcho "./vendor/kujaff/sf2scripts/composerupdate.sh -env=$sf2env -webserver-user=$webserverUser"

    elif [ "$script" = "schema" ]; then
        execCmdNoEcho "./vendor/kujaff/sf2scripts/schema.sh -env=$sf2env -webserver-user=$webserverUser"
    
    elif [ ${script:0:8} = "console:" ]; then
        title "Symfony2 console : ${script:8}"
        execConsole ${script:8}

    fi
done

#######
# fin #
#######

if [ "$endMessage" = "yes" ]; then
    block 42 "Update terminated"
fi
