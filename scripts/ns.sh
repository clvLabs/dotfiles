#!/bin/bash
# Start a New Shell (ns) in the current path

if [ -z $1 ]
then
  $TERM -e $SHELL -c "export PWD=\"$(pwd)\"; exec $SHELL" &
else
  $TERM -e $SHELL -c "export PWD=\"$(pwd)\"; exec $SHELL -c '$@'" &
fi
