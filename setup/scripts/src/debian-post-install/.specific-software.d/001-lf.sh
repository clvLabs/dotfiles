log_highlight -
log_highlight - [$APP_NAME] Installing lf
log_highlight -

TEMP_FOLDER=$(mktemp -d)
RUNCMD "wget -O $TEMP_FOLDER/lf.tar.gz https://github.com/gokcehan/lf/releases/download/r27/lf-linux-amd64.tar.gz"
RUNCMD "tar xvzf $TEMP_FOLDER/lf.tar.gz -C $TEMP_FOLDER"
RUNCMD "sudo mv $TEMP_FOLDER/lf /usr/bin"
RUNCMD "sudo rm -rf $TEMP_FOLDER"
