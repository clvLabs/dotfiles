log_highlight -
log_highlight - [${APP_NAME}] Installing vscode
log_highlight -

RUNCMD "wget --no-verbose -O- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg"
RUNCMD "echo deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main | sudo tee /etc/apt/sources.list.d/vscode.list"
RUNCMD "sudo apt-get update"
RUNCMD "sudo apt-get -y install code"
