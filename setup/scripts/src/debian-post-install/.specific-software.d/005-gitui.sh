log_highlight -
log_highlight - [${APP_NAME}] Installing gitui
log_highlight -

VERSION="0.21.0"
PLATFORM="linux-musl"

SOURCE_PATH="https://github.com/extrawurst/gitui/releases/download/v${VERSION}"
SOURCE_FILE="gitui-${PLATFORM}.tar.gz"

DEST_PATH="${HOME}/apps/gitui"
RUNCMD "mkdir -p ${DEST_PATH}"

TEMP_FOLDER=$(mktemp -d)
RUNCMD "wget --no-verbose -O ${TEMP_FOLDER}/${SOURCE_FILE} ${SOURCE_PATH}/${SOURCE_FILE}"
RUNCMD "tar xvzf ${TEMP_FOLDER}/${SOURCE_FILE} -C ${DEST_PATH}"
RUNCMD "ln -s ${DEST_PATH}/gitui ${HOME}/bin/gitui"
RUNCMD "rm -rf ${TEMP_FOLDER}"
