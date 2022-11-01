#!/bin/bash
find | entr -ncr python3 -u ${@}
