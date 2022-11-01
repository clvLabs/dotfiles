#!/bin/bash
SCRIPTNAME=${1}

if [ -z ${SCRIPTNAME} ]
then
  echo "Usage: ${0} SCRIPTNAME"
  echo "Install a script to ~/bin"
  echo
  echo "SCRIPTNAME must NOT include \".sh\""
  exit 1
fi

if [ -r ${SCRIPTNAME}.sh ]
then
  echo "Installing script ${SCRIPTNAME}.sh"
else
  echo "Install ERROR: script ${SCRIPTNAME}.sh does NOT exist" 1>&2
  exit 1
fi

echo "- Setting file permissions"
chmod 775 ${SCRIPTNAME}.sh

echo "- Creating symbolic link"
mkdir -p ~/bin
ln -sf $(pwd)/${SCRIPTNAME}.sh ~/bin/${SCRIPTNAME}

echo "- Done:"
ls -hAlF $(pwd)/${SCRIPTNAME}.sh
ls -hAlF ~/bin/${SCRIPTNAME}
