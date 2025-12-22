log_highlight -
log_highlight - [${APP_NAME}] Installing blender
log_highlight -

_MAJOR=5
_MINOR=0
_PATCH=1

PACKAGE="blender-${_MAJOR}.${_MINOR}.${_PATCH}-linux-x64"
SOURCE_PATH="https://download.blender.org/release/Blender${_MAJOR}.${_MINOR}"
SOURCE_FILE="${PACKAGE}.tar.xz"
TAR_FILE="${PACKAGE}.tar"

DEST_PATH="${HOME}/apps/blender"
RUNCMD "mkdir -p ${DEST_PATH}"

TEMP_FOLDER=$(mktemp -d -t ${APP_NAME}-blender-XXXXXX)

RUNCMD "wget --no-verbose -O ${TEMP_FOLDER}/${SOURCE_FILE} ${SOURCE_PATH}/${SOURCE_FILE}"
RUNCMD "cd ${TEMP_FOLDER}; xz -dv ${SOURCE_FILE}"
RUNCMD "tar xf ${TEMP_FOLDER}/${TAR_FILE} -C ${DEST_PATH}"
RUNCMD "ln -sf ${DEST_PATH}/${PACKAGE}/blender ${HOME}/bin/blender"
RUNCMD "rm -rf ${TEMP_FOLDER}"
