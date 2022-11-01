#!/bin/zsh
URL="https://api.chucknorris.io/jokes/random?category=dev,science,history"

JOKE_JSON=$(curl -s ${URL})

echo ${JOKE_JSON} | jq --raw-output '.value'
