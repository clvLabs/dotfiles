log_highlight -
log_highlight - [${APP_NAME}] Installing zsh-syntax-highlighting
log_highlight -

ZSH_CONFIG_BASE="/usr/share/zsh"
ZSH_PLUGINS_PATH="${ZSH_CONFIG_BASE}/plugins"

SOURCE_PATH="https://github.com/zsh-users/zsh-syntax-highlighting.git"

DEST_PATH="${ZSH_PLUGINS_PATH}/zsh-syntax-highlighting"

RUNCMD "sudo mkdir -p ${ZSH_PLUGINS_PATH}"
RUNCMD "sudo chown ${USER}:${USER} ${ZSH_PLUGINS_PATH}"
RUNCMD "git clone ${SOURCE_PATH} ${DEST_PATH}"
