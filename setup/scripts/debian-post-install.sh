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

log_highlight - [$APP_NAME] Updating package indexes
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt -y update"

log_highlight - [$APP_NAME] Removing unneeded software
APT_PURGE=$(echo $(sed "s/#.*$//g" $SETUP_RESOURCES_DIR/apt-purge.txt | cat))
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt -y purge $APT_PURGE"

log_highlight - [$APP_NAME] Cleaning packages
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt -y autoremove"
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt -y autoclean"

log_highlight - [$APP_NAME] Upgrading packages
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt -y upgrade"


log_title - ----------------------------------------------------------------------------
log_title -
log_title - [$APP_NAME] Installing software
log_title -

# --------------------------------------------------------------------------------------------------
log_highlight - [$APP_NAME] Installing package list for: apt
APT_INSTALL=$(echo $(sed "s/#.*$//g" $SETUP_RESOURCES_DIR/apt-install.txt | cat))
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt -y install $APT_INSTALL"

# --------------------------------------------------------------------------------------------------
log_highlight - [$APP_NAME] Installing package list for: snap
SNAP_INSTALL=$(echo $(sed "s/#.*$//g" $SETUP_RESOURCES_DIR/snap-install.txt | cat))
RUNCMD "sudo snap install $SNAP_INSTALL"

# --------------------------------------------------------------------------------------------------
log_highlight - [$APP_NAME] Installing package list for: pip
PIP_INSTALL=$(echo $(sed "s/#.*$//g" $SETUP_RESOURCES_DIR/pip-install.txt | cat))
RUNCMD "pip3 install $PIP_INSTALL"

# --------------------------------------------------------------------------------------------------
log_highlight - [$APP_NAME] Installing specific package: alacritty
RUNCMD "sudo add-apt-repository ppa:mmstick76/alacritty"
RUNCMD "sudo apt update"
RUNCMD "sudo apt install alacritty"

# --------------------------------------------------------------------------------------------------
log_highlight - [$APP_NAME] Installing specific package: brave-browser
RUNCMD "sudo apt install apt-transport-https curl"
RUNCMD "sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg"
RUNCMD "echo 'deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main'|sudo tee /etc/apt/sources.list.d/brave-browser-release.list"
RUNCMD "sudo apt update"
RUNCMD "sudo apt install brave-browser"

# --------------------------------------------------------------------------------------------------
log_highlight - [$APP_NAME] Installing specific package: spaceship-prompt
ZSH_CONFIG_BASE=/usr/share/zsh
RUNCMD "git clone https://github.com/denysdovhan/spaceship-prompt.git $ZSH_CONFIG_BASE/themes/spaceship-prompt"

# --------------------------------------------------------------------------------------------------
log_highlight - [$APP_NAME] Installing specific package: zsh-syntax-highlighting
ZSH_CONFIG_BASE=/usr/share/zsh
RUNCMD "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CONFIG_BASE/plugins/zsh-syntax-highlighting"

log_title - ----------------------------------------------------------------------------
log_title -
log_title - [$APP_NAME] Configuring system
log_title -

# --------------------------------------------------------------------------------------------------
log_highlight - [$APP_NAME] Setting ZSH as default shell
RUNCMD "chsh -s $(which zsh)"

# --------------------------------------------------------------------------------------------------
log_highlight - [$APP_NAME] Creating SSH key
RUNCMD "ssh-keygen -t rsa -C 'onixag@gmail.com'"

# --------------------------------------------------------------------------------------------------
log_highlight - [$APP_NAME] Granting access to serial ports
RUNCMD "sudo usermod -a -G dialout $USER"

log_title - ----------------------------------------------------------------------------
log_title -
log_title - [$APP_NAME] Installing dotfiles/utility scripts
log_title -

# --------------------------------------------------------------------------------------------------
log_highlight - [$APP_NAME] Running dotfiles installer
RUNCMD "$SETUP_SCRIPTS_DIR/dotfiles-install.sh"

# --------------------------------------------------------------------------------------------------
log_highlight - [$APP_NAME] Running utility script installer
RUNCMD "$SETUP_SCRIPTS_DIR/utils-install.sh"

# ############################################################################
#
# End of unattended section
#

log_success - ----------------------------------------------------------------------------
log_success -
log_success - [$APP_NAME] Setup finished successfully
log_success -
log_success - ----------------------------------------------------------------------------

if [ -z $DEBUG ]; then
  RUNCMD "cp --verbose $LOG_TEMPFILE $LOG_FILE"
fi
