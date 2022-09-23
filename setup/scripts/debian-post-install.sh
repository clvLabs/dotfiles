#!/bin/bash

# ############################################################################
#
# debian-post-install
#
# This script customizes a fresh-installed Debian.
#


# ############################################################################
#
# Script initialization
#

APP_NAME="debian-post-install"
THIS_SCRIPT_DIR=$(dirname "$(realpath "$0")")

SSH_KEY_EMAIL="onixag@gmail.com"

# Include source code
source $THIS_SCRIPT_DIR/src/utils.sh

LOG_FILE="${SETUP_LOGS_DIR}/${APP_NAME}.log"

# ############################################################################
#
# Avoid setup re-run
#

if [ -e $LOG_FILE ]; then
	log_error "$APP_NAME has already been run on this computer, see: ${LOG_FILE}."
  abort_setup
fi

# ############################################################################
#
# SETUP START
#

log_title - ----------------------------------------------------------------------------
log_title -
log_title - [$APP_NAME] Updating OS
log_title -

source $THIS_SCRIPT_DIR/src/debian-post-install/update-os.sh

log_title - ----------------------------------------------------------------------------
log_title -
log_title - [$APP_NAME] Installing software
log_title -

source $THIS_SCRIPT_DIR/src/debian-post-install/install-software-lists.sh
source $THIS_SCRIPT_DIR/src/debian-post-install/install-specific-software.sh

log_title - ----------------------------------------------------------------------------
log_title -
log_title - [$APP_NAME] Configuring system
log_title -

source $THIS_SCRIPT_DIR/src/debian-post-install/configure-system.sh

log_title - ----------------------------------------------------------------------------
log_title -
log_title - [$APP_NAME] Installing dotfiles/utility scripts
log_title -

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Running dotfiles installer
log_highlight -
RUNCMD "$SETUP_SCRIPTS_DIR/dotfiles-install.sh"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Running utility script installer
log_highlight -
RUNCMD "$SETUP_SCRIPTS_DIR/scripts-install.sh"

# ############################################################################
#
# End of unattended section
#

log_success - ----------------------------------------------------------------------------
log_success -
log_success - [$APP_NAME] Setup finished successfully
log_success -
log_warning - Please reboot
log_success -
log_success - ----------------------------------------------------------------------------

if [ -z $DEBUG ]; then
  RUNCMD "cp --verbose $LOG_TEMPFILE $LOG_FILE"
  RUNCMD "rm $LOG_TEMPFILE"
fi
