#!/bin/bash

LAST_SYNC_LOG_FILE=/var/log/data-backup.log

TITLE="Last backup on "
DATA=$(head -n 1 $LAST_SYNC_LOG_FILE)

DATA=${DATA::-11}

notify-send "last-data-backup" "$TITLE$DATA"
