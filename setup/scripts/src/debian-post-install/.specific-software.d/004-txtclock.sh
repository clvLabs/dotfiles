log_highlight -
log_highlight - [${APP_NAME}] Installing txtclock
log_highlight -

SOURCE_PATH="https://github.com/clvlabs/txtclock"

DEST_PATH="${HOME}/apps/txtclock"

RUNCMD "git clone ${SOURCE_PATH} ${DEST_PATH}"
RUNCMD "ln -s ${DEST_PATH}/txtclock/txtclock.py ${HOME}/bin/clock"
