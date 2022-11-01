log_highlight -
log_highlight - [$APP_NAME] Installing gitui
log_highlight -

SOURCE_PATH="https://github.com/extrawurst/gitui/releases/download/v0.21.0"
SOURCE_FILE="gitui-linux-musl.tar.gz"

DEST_PATH="${HOME}/apps/gitui"
RUNCMD "mkdir -p ${DEST_PATH}"

TEMP_FOLDER=$(mktemp -d)
RUNCMD "wget -O ${TEMP_FOLDER}/${SOURCE_FILE} ${SOURCE_PATH}/${SOURCE_FILE}"
RUNCMD "tar xvzf ${TEMP_FOLDER}/${SOURCE_FILE} -C ${DEST_PATH}"
RUNCMD "ln -s ${DEST_PATH}/gitui ${HOME}/bin/gitui"
RUNCMD "rm -rf ${TEMP_FOLDER}"
