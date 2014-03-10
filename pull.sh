#!/bin/bash

source vendor/kujaff/sf2scripts/functions.sh

title "Update branch '$(getGitBranch)'"
execCmd "git pull"
echoOk
exit 0