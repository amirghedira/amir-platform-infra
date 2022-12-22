#!/usr/bin/env bash

environment_set(){
    env="${1}"
    export PLAYBOOK="playbook-${env}.yml"
    export VAROPTS="@env/${env}.yml"
}
creating_env_file(){
    cat "SLACK_TOKEN=${CI_SLACK_TOKEN}" > ".env"
    cat "MONGO_URI=${CI_MONGO_URI}" >> ".env"
}
while getopts ":e:" option; do 
  case "$option" in 
    e) environment_set $OPTARG ;;
    esac 
done
 
echo "${VAROPTS}"
creating_env_file
source .env
sudo ansible-playbook $PLAYBOOK -e "$VAROPTS"
