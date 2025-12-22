#!/bin/zsh
printf "$1" | curl -F-=\<- qrenco.de
