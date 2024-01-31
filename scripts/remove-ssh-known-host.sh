#!/bin/zsh
HOST="192.168.1.$1"
echo "Removing host ${HOST} from known_hosts..."
ssh-keygen -f "${HOME}/.ssh/known_hosts" -R "${HOST}"
