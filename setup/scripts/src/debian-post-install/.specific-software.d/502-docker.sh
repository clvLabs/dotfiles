log_highlight -
log_highlight - [$APP_NAME] Installing docker
log_highlight -

RUNCMD "sudo mkdir -p /etc/apt/keyrings"
RUNCMD "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg"
RUNCMD "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null"
RUNCMD "sudo apt-get update"
RUNCMD "sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin"
RUNCMD "sudo groupadd docker"
RUNCMD "sudo usermod -aG docker $USER"

# See: https://unix.stackexchange.com/questions/18897/problem-while-running-newgrp-command-in-script
# RUNCMD "newgrp docker"
