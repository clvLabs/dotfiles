#!/bin/bash

# ############################################################################
#
# utils-install
#
# This script installs the utility scripts.
#

APP_NAME="utils-install"
THIS_SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Include source code
source $THIS_SCRIPT_DIR/src/utils.sh

TS="$(date --utc +%Y-%m-%dT%H:%M:%S)"
LOG_FILE="${SETUP_LOGS_DIR}/${APP_NAME}_${TS}.log"

log_title - ----------------------------------------------------------------------------
log_title -
log_title - [$APP_NAME] Installing utility scripts
log_title -

OLDPWD=$PWD
cd $UTILITY_SCRIPTS_DIR
SCRIPTS=$(find . -maxdepth 1 -type f)

for SCRIPT_FULLPATH in $SCRIPTS
do
  SCRIPT_FULLNAME=$(basename $SCRIPT_FULLPATH)
  SCRIPT_EXTENSION="${SCRIPT_FULLNAME##*.}"
  SCRIPT_NAME="${SCRIPT_FULLNAME%.*}"

  if [ "${SCRIPT_EXTENSION}" == "sh" ] \
  && [ "${SCRIPT_NAME}" != "_install" ] \
  && [ "${SCRIPT_NAME}" != "_uninstall" ]
  then
    log_highlight - [$APP_NAME] Installing $SCRIPT_NAME
    RUNCMD "./_install.sh $SCRIPT_NAME"
  fi

done

cd $OLDPWD

log_success - ----------------------------------------------------------------------------
log_success -
log_success - [$APP_NAME] Finished successfully
log_success -
log_success - ----------------------------------------------------------------------------

if [ -z $DEBUG ]; then
  RUNCMD "cp --verbose $LOG_TEMPFILE $LOG_FILE"
  RUNCMD "rm $LOG_TEMPFILE"
fi
