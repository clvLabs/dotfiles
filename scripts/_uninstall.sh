#!/bin/bash
if [ -z $1 ]
then
  echo "Usage: $0 SCRIPTNAME"
  echo "Uninstall a script from ~/bin"
  echo
  echo "SCRIPTNAME must NOT include \".sh\""
  exit 1
fi

if [ -r $1.sh ]
then
  echo "Uninstalling script $1.sh"
else
  echo "Uninstall ERROR: script $1.sh does NOT exist" 1>&2
  exit 1
fi

echo "- Removing symbolic link"
rm ~/bin/$1
