#!/bin/bash
# wpyl: watch changes in python files (follow symlinks) and run a python script
find -L -type f -name "*py" | entr -ncr python3 -u ${@}
