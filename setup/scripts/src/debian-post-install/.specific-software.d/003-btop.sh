log_highlight -
log_highlight - [${APP_NAME}] Installing btop
log_highlight -

VERSION="1.4.5"
PLATFORM="x86_64-linux-musl"

SOURCE_PATH="https://github.com/aristocratos/btop/releases/download/v${VERSION}"
SOURCE_FILE="btop-${PLATFORM}.tbz"

TEMP_FOLDER=$(mktemp -d -t ${APP_NAME}-btop-XXXXXX)

RUNCMD "wget --no-verbose -O ${TEMP_FOLDER}/${SOURCE_FILE} ${SOURCE_PATH}/${SOURCE_FILE}"
RUNCMD "mkdir -p ${TEMP_FOLDER}/extracted"
RUNCMD "tar -xjf ${TEMP_FOLDER}/${SOURCE_FILE} -C ${TEMP_FOLDER}/extracted"
RUNCMD "cd ${TEMP_FOLDER}/extracted/btop; ./install.sh"
RUNCMD "cd ${TEMP_FOLDER}/extracted/btop; ./setuid.sh"
RUNCMD "rm -rf ${TEMP_FOLDER}"
