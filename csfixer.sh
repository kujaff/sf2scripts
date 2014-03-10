#!/bin/bash

source vendor/kujaff/sf2scripts/functions.sh

dry="--dry-run"
if [ "$1" = "--fix" ]; then
    dry=""
fi

title "PHP cs fixer"
execCmd "php vendor/kujaff/sf2scripts/php-cs-fixer.phar fix . --config=sf21 --fixers=-return,-phpdoc_params,-eof_ending $dry" "Vos fichiers ne respectent pas les normes de dev. Configurez NetBeans pour les respecter. Exécutez \"./scripts/csfixer.sh --fix\" pour les appliquer temporairement."
echoOk
exit 0