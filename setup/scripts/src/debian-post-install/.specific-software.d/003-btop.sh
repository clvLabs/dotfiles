log_highlight -
log_highlight - [$APP_NAME] Installing btop
log_highlight -

TEMP_FOLDER=$(mktemp -d)
RUNCMD "mkdir -p $TEMP_FOLDER/extracted"
RUNCMD "wget -O $TEMP_FOLDER/btop.tbz https://github.com/aristocratos/btop/releases/download/v1.2.9/btop-x86_64-linux-musl.tbz"
RUNCMD "tar -xjf $TEMP_FOLDER/btop.tbz -C $TEMP_FOLDER/extracted"
RUNCMD "cd $TEMP_FOLDER/extracted; ./install.sh"
RUNCMD "cd $TEMP_FOLDER/extracted; ./setuid.sh"
RUNCMD "sudo rm -rf $TEMP_FOLDER"
