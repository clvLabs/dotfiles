log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Updating package indexes
log_highlight -
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt -y update"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Removing unneeded software
log_highlight -
APT_PURGE=$(echo $(sed "s/#.*$//g" $SETUP_RESOURCES_DIR/requirements/apt-purge.txt | cat))
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt -y purge $APT_PURGE"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Cleaning packages
log_highlight -
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt -y autoremove"
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt -y autoclean"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Upgrading packages
log_highlight -
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt -y upgrade"
