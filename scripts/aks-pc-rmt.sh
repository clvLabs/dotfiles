#!/bin/zsh
HOST=AKS_TAGUILAR.local
# USER="Tony Aguilar"
USER="taguilar"

if [[ -z "${1}" ]]; then
  HOST=s-reches.local
  # USER="taguilar"
fi

xfreerdp \
 /v:${HOST} \
 /cert:ignore \
 /u:"${USER}" \
 /dynamic-resolution \
 -grab-keyboard \
 +clipboard
