log_highlight -
log_highlight - [$APP_NAME] Installing zsh-syntax-highlighting
log_highlight -

ZSH_CONFIG_BASE=/usr/share/zsh
RUNCMD "sudo mkdir -p $ZSH_CONFIG_BASE/plugins"
RUNCMD "sudo chown $USER:$USER $ZSH_CONFIG_BASE/plugins"
RUNCMD "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CONFIG_BASE/plugins/zsh-syntax-highlighting"
