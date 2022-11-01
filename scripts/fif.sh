#!/bin/bash
grep \
 --color=auto \
 --binary-files=without-match \
 --recursive \
 --ignore-case \
 --perl-regexp \
 --include "*${1}" \
 "${2}" \
 ${3} ${4} ${5} ${6} ${7} ${8} ${9}
