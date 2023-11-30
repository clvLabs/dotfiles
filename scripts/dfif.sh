#!/bin/bash

fif ${@} \
| fzf \
--ansi \
--delimiter : \
--preview 'batcat --style=numbers --color=always --highlight-line {2} {1}' \
--preview-window +{2}-/2 \
--bind "enter:execute(code --reuse-window --goto {1}:{2})" \
