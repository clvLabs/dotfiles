log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [${APP_NAME}] Copying static base configuration files
log_highlight -
RUNCMD "sudo cp -rfv ${SETUP_RESOURCES_DIR}/static/etc/. /etc/"
RUNCMD "sudo cp -rfv ${SETUP_RESOURCES_DIR}/static/usr/. /usr/"
RUNCMD "sudo cp -rfv ${SETUP_RESOURCES_DIR}/static/var/. /var/"
RUNCMD "cp -rfv ${SETUP_RESOURCES_DIR}/static/home/. ${HOME}/"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [${APP_NAME}] Setting i3 as default window manager
log_highlight -

RUNCMD "sudo cp /var/lib/AccountsService/users/_user_template /var/lib/AccountsService/users/${USER}"
RUNCMD "sudo sed -i \"s/__USER__/${USER}/g\" /var/lib/AccountsService/users/${USER}"
RUNCMD "sudo rm /var/lib/AccountsService/users/_user_template "

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [${APP_NAME}] Setting ZSH as default shell
log_highlight -
RUNCMD "chsh -s $(which zsh)"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [${APP_NAME}] Creating SSH key
log_highlight -
RUNCMD "ssh-keygen -t rsa -C \'${SSH_KEY_EMAIL}\'"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [${APP_NAME}] Granting access to serial ports
log_highlight -
RUNCMD "sudo usermod -a -G dialout ${USER}"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [${APP_NAME}] Configuring motd
log_highlight -

RUNCMD "sudo chown ${USER}:${USER} /etc/motd"

CRON_TEMPFILE=$(mktemp -t ${APP_NAME}-cron-tempfile-XXXXXX)

RUNCMD "crontab -l > ${CRON_TEMPFILE}"
RUNCMD "touch ${CRON_TEMPFILE}"
RUNCMD "cat ${SETUP_RESOURCES_DIR}/partial/crontab >> ${CRON_TEMPFILE}"
RUNCMD "crontab ${CRON_TEMPFILE}"
RUNCMD "rm ${CRON_TEMPFILE}"
