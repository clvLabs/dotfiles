#!/bin/bash
CLIPBOARD="$(xclip -o)"

[ -d "${CLIPBOARD}" ] && export PWD=${CLIPBOARD}
