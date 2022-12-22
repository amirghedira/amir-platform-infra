#!/usr/bin/env bash

environment_set(){
    env="${1}"
    export PLAYBOOK="playbook-${env}.yml"
    export VAROPTS="@env/${env}.yml"
}

while getopts ":e:" option; do 
  case "$option" in 
    e) environment_set $OPTARG ;;
    esac 
done
 
echo "${VAROPTS}"
creating_env_file
source .env
sudo ansible-playbook $PLAYBOOK -e "$VAROPTS" --extra-vars "mongodb_uri=${CI_MONGO_URI} slack_token=${CI_SLACK_TOKEN}"
