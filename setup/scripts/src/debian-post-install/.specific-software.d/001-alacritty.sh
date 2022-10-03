log_highlight -
log_highlight - [$APP_NAME] Installing alacritty
log_highlight -

TEMP_FOLDER=$(mktemp -d)
RUNCMD "wget -O $TEMP_FOLDER/alacritty.deb https://github.com/barnumbirr/alacritty-debian/releases/download/v0.11.0-rc2-1/alacritty_0.11.0-rc2-1_amd64_bullseye.deb"
RUNCMD "sudo apt -y install $TEMP_FOLDER/alacritty.deb"
RUNCMD "sudo rm -rf $TEMP_FOLDER"
