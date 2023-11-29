#!/bin/bash
cat ${HOME}/.config/dmenu-custom/binlist.txt | dmenu "$@" | ${SHELL:-"/bin/sh"} &

