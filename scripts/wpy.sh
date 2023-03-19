#!/bin/bash
find -name "*py" | entr -ncr python3 -u ${@}
