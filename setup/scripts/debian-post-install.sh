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

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Updating package indexes
log_highlight -
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt -y update"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Removing unneeded software
log_highlight -
APT_PURGE=$(echo $(sed "s/#.*$//g" $SETUP_RESOURCES_DIR/apt-purge.txt | cat))
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

log_title - ----------------------------------------------------------------------------
log_title -
log_title - [$APP_NAME] Installing software
log_title -

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Installing package list for: apt
log_highlight -
APT_INSTALL=$(echo $(sed "s/#.*$//g" $SETUP_RESOURCES_DIR/apt-install.txt | cat))
RUNCMD "DEBIAN_FRONTEND=noninteractive sudo apt -y install $APT_INSTALL"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Installing package list for: snap
log_highlight -
SNAP_INSTALL=$(echo $(sed "s/#.*$//g" $SETUP_RESOURCES_DIR/snap-install.txt | cat))
RUNCMD "sudo snap install $SNAP_INSTALL"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Installing package list for: snap --classic
log_highlight -
SNAP_INSTALL=$(echo $(sed "s/#.*$//g" $SETUP_RESOURCES_DIR/snap-classic-install.txt | cat))
RUNCMD "sudo snap install $SNAP_INSTALL --classic"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Installing package list for: pip
log_highlight -
PIP_INSTALL=$(echo $(sed "s/#.*$//g" $SETUP_RESOURCES_DIR/pip-install.txt | cat))
RUNCMD "pip3 install $PIP_INSTALL"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Installing specific package: vscode
log_highlight -
RUNCMD "wget -O- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg"
RUNCMD "echo deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main | sudo tee /etc/apt/sources.list.d/vscode.list"
RUNCMD "sudo apt update"
RUNCMD "sudo apt -y install code"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Installing specific package: docker
log_highlight -
RUNCMD "sudo mkdir -p /etc/apt/keyrings"
RUNCMD "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg"
RUNCMD "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null"
RUNCMD "sudo apt update"
RUNCMD "sudo apt -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin"
RUNCMD "sudo groupadd docker"
RUNCMD "sudo usermod -aG docker $USER"
RUNCMD "newgrp docker"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Installing specific package: brave-browser
log_highlight -
RUNCMD "sudo apt install apt-transport-https curl"
RUNCMD "sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg"
RUNCMD "echo 'deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main'|sudo tee /etc/apt/sources.list.d/brave-browser-release.list"
RUNCMD "sudo apt update"
RUNCMD "sudo apt -y install brave-browser"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Installing specific package: lf
log_highlight -

OLDPWD=$PWD
TEMP_FOLDER=$(mktemp -d)
cd $TEMP_FOLDER
RUNCMD "wget https://github.com/gokcehan/lf/releases/download/r27/lf-linux-amd64.tar.gz"
RUNCMD "tar xvzf lf-linux-amd64.tar.gz"
RUNCMD "sudo mv lf /usr/bin"
cd $OLDPWD
RUNCMD "sudo rm -rf $TEMP_FOLDER"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Installing specific package: spaceship-prompt
log_highlight -
ZSH_CONFIG_BASE=/usr/share/zsh
RUNCMD "sudo mkdir -p $ZSH_CONFIG_BASE/themes"
RUNCMD "sudo chown $USER:$USER $ZSH_CONFIG_BASE/themes"
RUNCMD "git clone https://github.com/denysdovhan/spaceship-prompt.git $ZSH_CONFIG_BASE/themes/spaceship-prompt"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Installing specific package: zsh-syntax-highlighting
log_highlight -
ZSH_CONFIG_BASE=/usr/share/zsh
RUNCMD "sudo mkdir -p $ZSH_CONFIG_BASE/plugins"
RUNCMD "sudo chown $USER:$USER $ZSH_CONFIG_BASE/plugins"
RUNCMD "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CONFIG_BASE/plugins/zsh-syntax-highlighting"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Installing specific package: dejavu-sans-mono-nerd-font
log_highlight -

OLDPWD=$PWD
TEMP_FOLDER=$(mktemp -d)
FONT_DEST_FOLDER=/usr/share/fonts/truetype/nerd-fonts/dejavu-sans-mono
cd $TEMP_FOLDER
RUNCMD "wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/DejaVuSansMono.zip"
RUNCMD "sudo mkdir -p $FONT_DEST_FOLDER"
cd $FONT_DEST_FOLDER
RUNCMD "sudo unzip $TEMP_FOLDER/DejaVuSansMono.zip"
cd $OLDPWD
RUNCMD "sudo rm -rf $TEMP_FOLDER"
RUNCME "fc-cache --force --verbose"

log_title - ----------------------------------------------------------------------------
log_title -
log_title - [$APP_NAME] Configuring system
log_title -

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Setting screen resolution
log_highlight -
RUNCMD "sudo cp $SETUP_RESOURCES_DIR/custom-screen-resolution.sh /etc/profile.d"
RUNCMD "source $SETUP_RESOURCES_DIR/custom-screen-resolution.sh"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Setting ZSH as default shell
log_highlight -
RUNCMD "chsh -s $(which zsh)"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Creating SSH key
log_highlight -
RUNCMD "ssh-keygen -t rsa -C \'$SSH_KEY_EMAIL\'"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Granting access to serial ports
log_highlight -
RUNCMD "sudo usermod -a -G dialout $USER"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Configuring motd
log_highlight -

RUNCMD "sudo chown $USER:$USER /etc/motd"

CRON_TEMPFILE=$(mktemp)
RUNCMD "crontab -l > $CRON_TEMPFILE"
RUNCMD "touch $CRON_TEMPFILE"
RUNCMD "cat $SETUP_RESOURCES_DIR/crontab >> $CRON_TEMPFILE"
RUNCMD "crontab $CRON_TEMPFILE"
RUNCMD "rm $CRON_TEMPFILE"

log_title - ----------------------------------------------------------------------------
log_title -
log_title - [$APP_NAME] Installing dotfiles/utility scripts
log_title -

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Copying static base configuration files
log_highlight -
RUNCMD "cp -rfv $SETUP_RESOURCES_DIR/.config $HOME/.config"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Running dotfiles installer
log_highlight -
RUNCMD "$SETUP_SCRIPTS_DIR/dotfiles-install.sh"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Running utility script installer
log_highlight -
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
  RUNCMD "rm $LOG_TEMPFILE"
fi
