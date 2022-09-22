#!/bin/bash
HISTFILE=/home/tony/.zsh_history
cat $HISTFILE | awk -F  ";"  '{print $2}' | grep -P --color=ALWAYS "$1" $2 $3 $4 $5 $6 $7 $8 $9
