#!/bin/bash
SCRIPTNAME=${1}

if [ -z ${SCRIPTNAME} ]
then
  echo "Usage: ${0} SCRIPTNAME"
  echo "Uninstall a script from ~/bin"
  echo
  echo "SCRIPTNAME must NOT include \".sh\""
  exit 1
fi

if [ -r ${SCRIPTNAME}.sh ]
then
  echo "Uninstalling script ${SCRIPTNAME}.sh"
else
  echo "Uninstall ERROR: script ${SCRIPTNAME}.sh does NOT exist" 1>&2
  exit 1
fi

echo "- Removing symbolic link"
rm ~/bin/${SCRIPTNAME}
