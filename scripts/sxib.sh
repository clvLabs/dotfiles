#!/bin/bash
FULLPATH=${1}
FILE=$(basename "${FULLPATH}")
FOLDER=$(dirname "${FULLPATH}")
FILENUM=$(ls "${FOLDER}" | grep --line-number ${FILE} | sed "s/\:.*//")
sxiv -a -f -s f -n ${FILENUM} "${FOLDER}"
