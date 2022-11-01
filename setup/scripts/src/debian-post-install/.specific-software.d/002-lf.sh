log_highlight -
log_highlight - [${APP_NAME}] Installing lf
log_highlight -

VERSION="r27"
PLATFORM="linux-amd64"

SOURCE_PATH="https://github.com/gokcehan/lf/releases/download/${VERSION}"
SOURCE_FILE="lf-${PLATFORM}.tar.gz"

DEST_PATH="${HOME}/apps/lf"
RUNCMD "mkdir -p ${DEST_PATH}"

TEMP_FOLDER=$(mktemp -d -t ${APP_NAME}-lf-XXXXXX)

RUNCMD "wget --no-verbose -O ${TEMP_FOLDER}/${SOURCE_FILE} ${SOURCE_PATH}/${SOURCE_FILE}"
RUNCMD "tar xzf ${TEMP_FOLDER}/${SOURCE_FILE} -C ${DEST_PATH}"
RUNCMD "ln -s ${DEST_PATH}/lf ${HOME}/bin/lf"
RUNCMD "rm -rf ${TEMP_FOLDER}"
