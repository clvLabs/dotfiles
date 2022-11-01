log_highlight -
log_highlight - [${APP_NAME}] Installing spotify
log_highlight -

RUNCMD "curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - "
RUNCMD "echo \"deb http://repository.spotify.com stable non-free\" | sudo tee /etc/apt/sources.list.d/spotify.list"
RUNCMD "sudo apt-get update"
RUNCMD "sudo apt-get -y install spotify-client"
