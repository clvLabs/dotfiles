log_highlight -
log_highlight - [$APP_NAME] Installing txtclock
log_highlight -

RUNCMD "git clone https://github.com/clvlabs/txtclock ${HOME}/apps/txtclock"
RUNCMD "ln -s ${HOME}/apps/txtclock/txtclock/txtclock.py ${HOME}/bin/clock"
