log_highlight -
log_highlight - [$APP_NAME] Installing blender
log_highlight -

_MAJOR=3
_MINOR=3
_PATCH=0

PACKAGE="blender-${_MAJOR}.${_MINOR}.${_PATCH}-linux-x64"
SOURCE_URL="https://download.blender.org/release/Blender${_MAJOR}.${_MINOR}/${PACKAGE}.tar.xz"

TEMP_FOLDER=$(mktemp -d)

XZ_FILE="${TEMP_FOLDER}/${PACKAGE}.tar.xz"
TAR_FILE="${TEMP_FOLDER}/${PACKAGE}.tar"

RUNCMD "wget -O $XZ_FILE $SOURCE_URL"
RUNCMD "cd $TEMP_FOLDER; xz -dv $XZ_FILE"
RUNCMD "mkdir -p ~/blender"
RUNCMD "tar xvf $TAR_FILE -C ~/blender"
RUNCMD "ln -sf ~/blender/${PACKAGE}/blender ~/bin/blender"
RUNCMD "sudo rm -rf $TEMP_FOLDER"
