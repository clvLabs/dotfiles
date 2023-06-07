#!/bin/sh
echo "$@" | socat - "$HOME/.config/mpv/socket"
