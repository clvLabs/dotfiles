#!/bin/bash
# wpy: watch changes in python files and run a python script
find -type f -name "*py" | entr -ncr python3 -u ${@}
