sf2scripts
==========

Scripts for Symfony2

Installation
============

Composer :

  # composer.json
  {
    "require": {
        "kujaff/sf2scripts": "dev-master",
    }
  }


Utilisation
===========

Main script is scripts.sh, you can call simply call it :
  ./vendor/kujaff/sf2scripts/scripts.sh

Parameters :

  -env=[dev|prod|yourEnv]
    symfony2 environment (most os the time dev or prod)
    default : dev
    
  -confirm=[true|false]
    if you are on master branch, confirm parameter indicate if you to confirm script excution
    
  -scripts=script1,script2,console:mySF2Command
    scripts to execute, can call SF2 console command with "console:" prefix
    default : dirs,cache,pull,composerinstall,schema

Scripts availables :
  - cache
    Delete everything in app/cache
    
  - composerinstall
    Execute composer install, with --no-dev parameter if -env=prod
  
  - composerinstall
    Execute composer install, with --no-dev parameter if -env=prod
    
  - csfixer
    Execute php-cs-fixer.phar with SF2 php syntax
    
  - dirs
    Create app/cache and app/logs, and set credentials (setfacl or chmod 777)
    
  - doctrinecache
    Clear doctrine cache
    
  - pull
    Execute git pull
    
  - schema
    Update database, with SF2 command "doctrine:schema:update --force"
