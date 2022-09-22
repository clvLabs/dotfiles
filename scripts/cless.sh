#!/bin/zsh
# cless: colored less
# pygmentize -O style=monokai -f console256 -g $@ | less -R
batcat --style=full --color=always $@ | less -R
