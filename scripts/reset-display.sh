#!/bin/bash
xrandr \
--output DVI-I-1 --mode 1920x1080 --pos 0x0 \
--output DP-3 --mode 2560x1440 --pos 1920x-350 \
--output DP-2 --mode 1920x1080 --pos 4480x-400 --rotate left
