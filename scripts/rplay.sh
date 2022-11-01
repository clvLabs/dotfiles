#!/bin/bash
mplayer -playlist <(find "${PWD}/${1}" -name "*.mp3" -type f | sort)
