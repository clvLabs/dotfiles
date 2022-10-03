log_highlight -
log_highlight - [$APP_NAME] Installing slack
log_highlight -

TEMP_FOLDER=$(mktemp -d)
RUNCMD "wget -O $TEMP_FOLDER/slack.deb  https://downloads.slack-edge.com/linux_releases/slack-desktop-4.0.2-amd64.deb"
RUNCMD "sudo apt -y install $TEMP_FOLDER/slack.deb"
RUNCMD "sudo rm -rf $TEMP_FOLDER"
