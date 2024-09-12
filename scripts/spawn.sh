#!/bin/bash
SELFNAME="${0}"
NUMTIMES="${1}"
shift
COMMAND="$@"


function show_usage () {
  echo "Usage:"
  echo "$SELFNAME <NUMTIMES> <COMMAND>"
}


if [[ -z "${NUMTIMES}" ]]; then
  show_usage
  exit 1
fi

if [[ -z "${COMMAND}" ]]; then
  show_usage
  exit 1
fi

for ((i = 1; i <= ${NUMTIMES}; i++ )); do
  echo "[$i] $COMMAND"
  $($COMMAND) &
done

disown
