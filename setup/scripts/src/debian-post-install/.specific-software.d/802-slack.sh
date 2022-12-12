log_highlight -
log_highlight - [${APP_NAME}] Installing slack
log_highlight -

VERSION="4.29.149"
PLATFORM="amd64"

SOURCE_PATH="https://downloads.slack-edge.com/linux_releases"
SOURCE_FILE="slack-desktop-${VERSION}-${PLATFORM}.deb"

TEMP_FOLDER=$(mktemp -d -t ${APP_NAME}-slack-XXXXXX)

RUNCMD "wget --no-verbose -O ${TEMP_FOLDER}/${SOURCE_FILE} ${SOURCE_PATH}/${SOURCE_FILE}"
RUNCMD "sudo apt-get -y install ${TEMP_FOLDER}/${SOURCE_FILE}"
RUNCMD "rm -rf ${TEMP_FOLDER}"
