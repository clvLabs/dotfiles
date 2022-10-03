log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Installing package list for: apt
log_highlight -
APT_INSTALL=$(echo $(sed "s/#.*$//g" $SETUP_RESOURCES_DIR/requirements/apt-install.txt | cat))
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt -y install $APT_INSTALL"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Installing package list for: pip
log_highlight -
PIP_INSTALL=$(echo $(sed "s/#.*$//g" $SETUP_RESOURCES_DIR/requirements/pip-install.txt | cat))
RUNCMD "pip3 install $PIP_INSTALL"
