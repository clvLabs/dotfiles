#!/bin/bash
HISTFILE=${HOME}/.zsh_history
cat ${HISTFILE} | awk -F  ";"  '{print $2}' | fzf
