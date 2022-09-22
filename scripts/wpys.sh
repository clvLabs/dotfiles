#!/bin/bash
echo $1 | entr -ncr python3 -u $@
