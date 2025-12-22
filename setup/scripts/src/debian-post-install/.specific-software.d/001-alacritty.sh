log_highlight -
log_highlight - [${APP_NAME}] Installing alacritty
log_highlight -

VERSION="0.12.0-1"
PLATFORM="amd64_bullseye"

SOURCE_PATH="https://github.com/barnumbirr/alacritty-debian/releases/download/v${VERSION}"
SOURCE_FILE="alacritty_${VERSION}_${PLATFORM}.deb"

TEMP_FOLDER=$(mktemp -d -t ${APP_NAME}-alacritty-XXXXXX)

RUNCMD "wget --no-verbose -O ${TEMP_FOLDER}/${SOURCE_FILE} ${SOURCE_PATH}/${SOURCE_FILE}"
RUNCMD "sudo apt-get -y install ${TEMP_FOLDER}/${SOURCE_FILE}"
RUNCMD "rm -rf ${TEMP_FOLDER}"
