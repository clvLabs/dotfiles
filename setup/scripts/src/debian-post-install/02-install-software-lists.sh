log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [${APP_NAME}] Installing package list for: apt
log_highlight -
# APT_INSTALL=$(echo $(sed "s/#.*$//g" ${SETUP_RESOURCES_DIR}/requirements/apt-install.txt | cat))
# RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt-get -y install ${APT_INSTALL}"
APT_INSTALL=$(echo $(sed "s/#.*$//g" ${SETUP_RESOURCES_DIR}/requirements/apt-install.txt | cat))
for PKG in ${APT_INSTALL}; do
  RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt-get -y install ${PKG}"
done
