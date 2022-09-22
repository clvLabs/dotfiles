#!/bin/zsh
url="https://api.chucknorris.io/jokes/random?category=dev,science,history"

joke_json=$(curl -s $url)

echo $joke_json \
| jq --raw-output '.value'
