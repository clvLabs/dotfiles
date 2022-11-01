
log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [${APP_NAME}] Installing specific packages
log_highlight -

# ~/bin created for locally installed app links
mkdir -p ${HOME}/bin

# ~/apps created for locally installed apps
mkdir -p ${HOME}/apps

cat ${POST_INSTALL_SRC_DIR}/.specific-software.d/*.sh > ${POST_INSTALL_SRC_DIR}/specific-software.bundle
source ${POST_INSTALL_SRC_DIR}/specific-software.bundle
rm ${POST_INSTALL_SRC_DIR}/specific-software.bundle
