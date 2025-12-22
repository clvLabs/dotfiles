log_highlight -
log_highlight - [${APP_NAME}] Installing spotify
log_highlight -

RUNCMD "curl -sS https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg"
RUNCMD "echo \"deb https://repository.spotify.com stable non-free\" | sudo tee /etc/apt/sources.list.d/spotify.list"
RUNCMD "sudo apt-get update"
RUNCMD "sudo apt-get -y install spotify-client"
