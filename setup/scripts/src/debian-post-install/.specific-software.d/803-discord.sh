log_highlight -
log_highlight - [${APP_NAME}] Installing discord
log_highlight -

SOURCE_URL="https://discordapp.com/api/download?platform=linux&format=deb"

SOURCE_FILE="discord.deb"

TEMP_FOLDER=$(mktemp -d -t ${APP_NAME}-discord-XXXXXX)

RUNCMD "wget --no-verbose -O ${TEMP_FOLDER}/${SOURCE_FILE} \"${SOURCE_URL}\""
RUNCMD "sudo apt-get -y install ${TEMP_FOLDER}/${SOURCE_FILE}"
RUNCMD "rm -rf ${TEMP_FOLDER}"
