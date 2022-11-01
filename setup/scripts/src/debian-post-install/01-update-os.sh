log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [${APP_NAME}] Updating apt package indexes
log_highlight -
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt-get -y update"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [${APP_NAME}] Removing unneeded software
log_highlight -
APT_PURGE=$(echo $(sed "s/#.*$//g" ${SETUP_RESOURCES_DIR}/requirements/apt-purge.txt | cat))
for PKG in ${APT_PURGE}; do
  RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt-get -y purge ${PKG}"
done

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [${APP_NAME}] Cleaning apt packages
log_highlight -
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt-get -y autoremove"
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt-get -y autoclean"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [${APP_NAME}] Upgrading apt packages
log_highlight -
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt-get -y upgrade"
