#!/bin/bash

# ############################################################################
#
# dotfiles-install
#
# This script installs the configuration files.
#

APP_NAME="dotfiles-install"
THIS_SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Include source code
source $THIS_SCRIPT_DIR/src/utils.sh

TS="$(date --utc +%Y-%m-%dT%H:%M:%S)"
LOG_FILE="${SETUP_LOGS_DIR}/${APP_NAME}_${TS}.log"

log_title - ----------------------------------------------------------------------------
log_title -
log_title - [$APP_NAME] Installing config files
log_title -

# --------------------------------------------------------------------------------------------------
FILES=$(find ${CONFIG_DIR}/home -maxdepth 1 -mindepth 1 -type f)

for FILE in $FILES
do
  FILE_FULLPATH=$(realpath $FILE)
  FILE_FULLNAME=$(basename $FILE_FULLPATH)
  FILE_EXTENSION="${FILE_FULLNAME##*.}"
  FILE_NAME="${FILE_FULLNAME%.*}"

  log_highlight - [$APP_NAME] Creating symlink for $FILE_FULLNAME
  RUNCMD "rm $HOME/$FILE_FULLNAME"
  RUNCMD "ln -sf $FILE_FULLPATH $HOME/$FILE_FULLNAME"
done

# --------------------------------------------------------------------------------------------------
FOLDERS=$(find ${CONFIG_DIR}/home/.config -maxdepth 1 -mindepth 1 -type d)

for FOLDER in $FOLDERS
do
  FOLDER_FULLPATH=$(realpath $FOLDER)
  FOLDER_FULLNAME=$(basename $FOLDER_FULLPATH)

  log_highlight - [$APP_NAME] Creating symlink for .config/$FOLDER_FULLNAME
  RUNCMD "rm $HOME/.config/$FOLDER_FULLNAME"
  RUNCMD "ln -sf $FOLDER_FULLPATH $HOME/.config/$FOLDER_FULLNAME"
done

log_success - ----------------------------------------------------------------------------
log_success -
log_success - [$APP_NAME] Finished successfully
log_success -
log_success - ----------------------------------------------------------------------------

if [ -z $DEBUG ]; then
  RUNCMD "cp --verbose $LOG_TEMPFILE $LOG_FILE"
fi
