log_highlight -
log_highlight - [$APP_NAME] Installing spaceship-prompt
log_highlight -

ZSH_CONFIG_BASE=/usr/share/zsh
RUNCMD "sudo mkdir -p $ZSH_CONFIG_BASE/themes"
RUNCMD "sudo chown $USER:$USER $ZSH_CONFIG_BASE/themes"
RUNCMD "git clone https://github.com/denysdovhan/spaceship-prompt.git $ZSH_CONFIG_BASE/themes/spaceship-prompt"
