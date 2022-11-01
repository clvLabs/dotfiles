log_highlight -
log_highlight - [${APP_NAME}] Installing brave-browser
log_highlight -

RUNCMD "sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg"
RUNCMD "echo 'deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main'|sudo tee /etc/apt/sources.list.d/brave-browser-release.list"
RUNCMD "sudo apt-get update"
RUNCMD "sudo apt-get -y install brave-browser"
