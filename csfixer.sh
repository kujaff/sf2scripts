#!/bin/bash

source vendor/kujaff/sf2scripts/functions.sh

dry="--dry-run"
if [ "$1" = "--fix" ]; then
    dry=""
fi

title "Verification des normes de dev"
execCmd "php scripts/php-cs-fixer.phar fix . --config=sf21 --fixers=-return,-phpdoc_params,-eof_ending $dry" "Vos fichiers ne respectent pas les normes de dev. Configurez NetBeans pour les respecter. Exécutez \"./scripts/csfixer.sh --fix\" pour les appliquer temporairement."
echoOk