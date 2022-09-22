#!/bin/bash
if [ -z $1 ]
then
  echo "Usage: $0 SCRIPTNAME"
  echo "Install a script to ~/bin"
  echo
  echo "SCRIPTNAME must NOT include \".sh\""
  exit 1
fi

if [ -r $1.sh ]
then
  echo "Installing script $1.sh"
else
  echo "Install ERROR: script $1.sh does NOT exist" 1>&2
  exit 1
fi

echo "- Setting file permissions"
chmod 775 $1.sh

echo "- Creating symbolic link"
mkdir -p ~/bin
ln -sf $(pwd)/$1.sh ~/bin/$1

echo "- Done:"
ls -hAlF $(pwd)/$1.sh
ls -hAlF ~/bin/$1
