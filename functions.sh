#!/bin/bash

autoNewLine=false

if [ "$sf2env" = "" ]; then
    sf2env="dev"
    for param in $*; do
        if [ ${param:0:5} == '-env=' ]; then
            sf2env=${param:5}
        fi
    done
fi

webserverUser="www-data"
verbose=""
for param in $*; do
    if [ ${param:0:16} == '-webserver-user=' ]; then
        webserverUser=${param:16}
    elif [ ${param:0:2} == '-v' ]; then
        verbose="v"
    fi
done

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

function createDir777() {
    if [ ! -d "$1" ]; then
        execCmd "sudo mkdir $1"
    fi

    type setfacl > /dev/null 2>/dev/null
    if [ $? = 0 ]; then
        execCmd "sudo setfacl -R -m u:$webserverUser:rwX -m u:`whoami`:rwX $1"
        execCmd "sudo setfacl -dR -m u:$webserverUser:rwX -m u:`whoami`:rwX $1"
    else
        execCmd "sudo chmod -R 777 $1"
    fi
}

function cancelScript() {
    if [ "$1" = "" ]; then
        message="Script canceled, error occured."
    else
        message=$1
    fi
    echo -en "\n\n"
    block 41 "$message"
    exit 1
}

function echoOk() {
    echo -en "\n[\033[32m OK \033[00m]\n";
}

function execCmd() {
    if [[ ( "$3" == "" && $autoNewLine == true ) || $3 == true ]]; then
        echo ""
    fi
    echo -en "\033[45m\033[1;37m$ $1\033[0m\n"
    execCmdNoEcho "$1" "$2" false
}

function execCmdNoEcho() {
    if [ "$verbose" = "v" ]; then
        $1
    else
        $1 > /dev/null
    fi
    [ "$?" != "0" ] && cancelScript "$2"

    autoNewLine=true
}

function execConsole() {
    execCmd "sudo -u $webserverUser php app/console --env=$sf2env $1";
}
