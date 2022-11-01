log_highlight -
log_highlight - [${APP_NAME}] Installing dejavu-sans-mono-nerd-font
log_highlight -

VERSION="2.2.2"

SOURCE_PATH="https://github.com/ryanoasis/nerd-fonts/releases/download/v${VERSION}"
SOURCE_FILE="DejaVuSansMono.zip"

DEST_PATH="/usr/share/fonts/truetype/nerd-fonts/dejavu-sans-mono"
RUNCMD "sudo mkdir -p ${DEST_PATH}"

TEMP_FOLDER=$(mktemp -d -t ${APP_NAME}-dejavu-sans-mono-XXXXXX)

RUNCMD "wget --no-verbose -O ${TEMP_FOLDER}/${SOURCE_FILE} ${SOURCE_PATH}/${SOURCE_FILE}"
RUNCMD "sudo unzip ${TEMP_FOLDER}/${SOURCE_FILE} -d ${DEST_PATH}"
RUNCMD "rm -rf ${TEMP_FOLDER}"
RUNCMD "fc-cache --force"
