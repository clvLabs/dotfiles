#!/bin/bash
# wpya: watch changes in (ALL) files and run a python script
find -type f  | entr -ncr python3 -u ${@}
