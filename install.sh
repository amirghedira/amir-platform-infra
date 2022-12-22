#!/usr/bin/env bash

environment_set(){
    env="${1}"
    export PLAYBOOK="playbook-${env}.yml"
    export VAROPTS="@env/${env}.yml"
    export SLACK_TOKEN=${CI_SLACK_TOKEN}
    export MONGO_URI=${CI_MONGO_URI}
}
while getopts ":e:" option; do 
  case "$option" in 
    e) environment_set $OPTARG ;;
    esac 
done
 
echo "${VAROPTS}"
sudo ansible-playbook $PLAYBOOK -e "$VAROPTS"
