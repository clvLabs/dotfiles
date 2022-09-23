log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Installing specific package: vscode
log_highlight -
RUNCMD "wget -O- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg"
RUNCMD "echo deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main | sudo tee /etc/apt/sources.list.d/vscode.list"
RUNCMD "sudo apt update"
RUNCMD "sudo apt -y install code"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Installing specific package: docker
log_highlight -
RUNCMD "sudo mkdir -p /etc/apt/keyrings"
RUNCMD "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg"
RUNCMD "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null"
RUNCMD "sudo apt update"
RUNCMD "sudo apt -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin"
RUNCMD "sudo groupadd docker"
RUNCMD "sudo usermod -aG docker $USER"

# See: https://unix.stackexchange.com/questions/18897/problem-while-running-newgrp-command-in-script
# RUNCMD "newgrp docker"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Installing specific package: brave-browser
log_highlight -
RUNCMD "sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg"
RUNCMD "echo 'deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main'|sudo tee /etc/apt/sources.list.d/brave-browser-release.list"
RUNCMD "sudo apt update"
RUNCMD "sudo apt -y install brave-browser"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Installing specific package: lf
log_highlight -

TEMP_FOLDER=$(mktemp -d)
RUNCMD "wget -O $TEMP_FOLDER/lf.tar.gz https://github.com/gokcehan/lf/releases/download/r27/lf-linux-amd64.tar.gz"
RUNCMD "tar xvzf $TEMP_FOLDER/lf.tar.gz -C $TEMP_FOLDER"
RUNCMD "sudo mv $TEMP_FOLDER/lf /usr/bin"
RUNCMD "sudo rm -rf $TEMP_FOLDER"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Installing specific package: spaceship-prompt
log_highlight -
ZSH_CONFIG_BASE=/usr/share/zsh
RUNCMD "sudo mkdir -p $ZSH_CONFIG_BASE/themes"
RUNCMD "sudo chown $USER:$USER $ZSH_CONFIG_BASE/themes"
RUNCMD "git clone https://github.com/denysdovhan/spaceship-prompt.git $ZSH_CONFIG_BASE/themes/spaceship-prompt"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Installing specific package: zsh-syntax-highlighting
log_highlight -
ZSH_CONFIG_BASE=/usr/share/zsh
RUNCMD "sudo mkdir -p $ZSH_CONFIG_BASE/plugins"
RUNCMD "sudo chown $USER:$USER $ZSH_CONFIG_BASE/plugins"
RUNCMD "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CONFIG_BASE/plugins/zsh-syntax-highlighting"

log_highlight - ----------------------------------------------------------------------------
log_highlight -
log_highlight - [$APP_NAME] Installing specific package: dejavu-sans-mono-nerd-font
log_highlight -

TEMP_FOLDER=$(mktemp -d)
FONT_DEST_FOLDER=/usr/share/fonts/truetype/nerd-fonts/dejavu-sans-mono
RUNCMD "wget -O $TEMP_FOLDER/DejaVuSansMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/DejaVuSansMono.zip"
RUNCMD "sudo mkdir -p $FONT_DEST_FOLDER"
RUNCMD "sudo unzip $TEMP_FOLDER/DejaVuSansMono.zip -d $FONT_DEST_FOLDER"
RUNCMD "sudo rm -rf $TEMP_FOLDER"
RUNCMD "fc-cache --force --verbose"
