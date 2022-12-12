log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [${APP_NAME}] Enabling "contrib" and "non-free" package repositories
log_highlight -
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt-add-repository contrib"
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt-add-repository non-free"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [${APP_NAME}] Updating apt package indexes
log_highlight -
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt-get -y update"
