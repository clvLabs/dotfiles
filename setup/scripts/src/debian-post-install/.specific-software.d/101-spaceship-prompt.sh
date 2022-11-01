log_highlight -
log_highlight - [${APP_NAME}] Installing spaceship-prompt
log_highlight -

ZSH_CONFIG_BASE="/usr/share/zsh"
ZSH_THEMES_PATH="${ZSH_CONFIG_BASE}/themes"

SOURCE_PATH="https://github.com/denysdovhan/spaceship-prompt.git"

DEST_PATH="${ZSH_THEMES_PATH}/spaceship-prompt"

RUNCMD "sudo mkdir -p ${ZSH_THEMES_PATH}"
RUNCMD "sudo chown ${USER}:${USER} ${ZSH_THEMES_PATH}"
RUNCMD "git clone ${SOURCE_PATH} ${DEST_PATH}"
