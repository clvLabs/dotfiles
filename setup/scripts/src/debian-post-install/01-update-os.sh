log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [${APP_NAME}] Enabling "contrib" and "non-free" package repositories
log_highlight -
RUNCMD "sudo sed -i 's/non-free-firmware/non-free-firmware contrib non-free/' /etc/apt/sources.list"


log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [${APP_NAME}] Updating apt package indexes
log_highlight -
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt-get -y update"
