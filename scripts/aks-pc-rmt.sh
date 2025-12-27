#!/bin/zsh
HOST=AKS_TAGUILAR.local
USER="taguilar"

if ! [[ -z "${1}" ]]; then
  HOST=s-reches.local
fi

PASS=$(yad --text "Password for $HOST" --entry --hide-text)

if [[ -z "${PASS}" ]]; then
  exit 0
fi

xfreerdp3 \
 /v:${HOST} \
 /cert:ignore \
 /d:"" \
 /u:"${USER}" \
 /p:"${PASS}" \
 /dynamic-resolution \
 -grab-keyboard \
 +clipboard
