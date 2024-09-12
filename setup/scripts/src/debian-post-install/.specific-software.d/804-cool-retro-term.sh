log_highlight -
log_highlight - [${APP_NAME}] Installing cool-retro-term
log_highlight -

VERSION="dac2b4f"
PLATFORM="x86_64"

SOURCE_PATH="https://github.com/Swordfish90/cool-retro-term/releases/download/continuous"
SOURCE_FILE="Cool_Retro_Term-${VERSION}-${PLATFORM}.AppImage"

APPIMG_FOLDER="~/AppImage/cool-retro-term"

RUNCMD "mkdir --parents ${APPIMG_FOLDER}"
RUNCMD "wget --no-verbose -O ${APPIMG_FOLDER}/${SOURCE_FILE} ${SOURCE_PATH}/${SOURCE_FILE}"
RUNCMD "chmod +x ${APPIMG_FOLDER}/${SOURCE_FILE}"
RUNCMD "ln -sf ${APPIMG_FOLDER}/${SOURCE_FILE} cool-retro-terminal"
