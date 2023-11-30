#!/bin/bash
grep \
 --color=always \
 --binary-files=without-match \
 --recursive \
 --ignore-case \
 --perl-regexp \
 --line-number \
 --include "*${1}" \
 "${2}" \
 ${3} ${4} ${5} ${6} ${7} ${8} ${9}
