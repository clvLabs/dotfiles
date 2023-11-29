#!/bin/bash
# wpy: watch changes in (a single python file) and run it
echo ${1} | entr -ncr python3 -u ${@}
