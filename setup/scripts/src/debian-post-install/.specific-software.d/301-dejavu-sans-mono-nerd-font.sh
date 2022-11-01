log_highlight -
log_highlight - [$APP_NAME] Installing dejavu-sans-mono-nerd-font
log_highlight -

TEMP_FOLDER=$(mktemp -d)
FONT_DEST_FOLDER=/usr/share/fonts/truetype/nerd-fonts/dejavu-sans-mono
RUNCMD "wget --no-verbose -O $TEMP_FOLDER/DejaVuSansMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/DejaVuSansMono.zip"
RUNCMD "sudo mkdir -p $FONT_DEST_FOLDER"
RUNCMD "sudo unzip $TEMP_FOLDER/DejaVuSansMono.zip -d $FONT_DEST_FOLDER"
RUNCMD "sudo rm -rf $TEMP_FOLDER"
RUNCMD "fc-cache --force --verbose"
