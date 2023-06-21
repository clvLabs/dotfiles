#!/bin/bash


# ############################################################################
#
# Script initialization
#

APP_NAME="nas-backup"

SOURCE_FOLDER=$HOME

NAS_HOST=telinetsrv.local
NAS_USER=$USER
DEST_FOLDER=${NAS_USER}@${NAS_HOST}::home/backup

RSYNC_PASS_FILE=$HOME/.config/.rsynccredentials.d/${NAS_HOST}

BACKUP_FOLDERS=""
BACKUP_FOLDERS="${BACKUP_FOLDERS} Documents"
BACKUP_FOLDERS="${BACKUP_FOLDERS} src"


# From: man rsync
#
# --archive, -a            archive mode is -rlptgoD (no -A,-X,-U,-N,-H)
#
# --recursive, -r          recurse into directories
# --links, -l              copy symlinks as symlinks
# --perms, -p              preserve permissions
# --times, -t              preserve modification times
# --group, -g              preserve group
# --owner, -o              preserve owner (super-user only)
# -D                       same as --devices --specials
# --devices                preserve device files (super-user only)
# --specials               preserve special files


RSYNC_BASE_PARAMS=""
# RSYNC_BASE_PARAMS="${RSYNC_BASE_PARAMS} --archive"
RSYNC_BASE_PARAMS="${RSYNC_BASE_PARAMS} --recursive"
RSYNC_BASE_PARAMS="${RSYNC_BASE_PARAMS} --links"
RSYNC_BASE_PARAMS="${RSYNC_BASE_PARAMS} --perms"
RSYNC_BASE_PARAMS="${RSYNC_BASE_PARAMS} --times"
# RSYNC_BASE_PARAMS="${RSYNC_BASE_PARAMS} --group"
# RSYNC_BASE_PARAMS="${RSYNC_BASE_PARAMS} --owner"
RSYNC_BASE_PARAMS="${RSYNC_BASE_PARAMS} -D"
RSYNC_BASE_PARAMS="${RSYNC_BASE_PARAMS} --devices"
RSYNC_BASE_PARAMS="${RSYNC_BASE_PARAMS} --specials"

RSYNC_BASE_PARAMS="${RSYNC_BASE_PARAMS} --password-file $RSYNC_PASS_FILE"

RSYNC_BASE_PARAMS="${RSYNC_BASE_PARAMS} --delete"
RSYNC_BASE_PARAMS="${RSYNC_BASE_PARAMS} --human-readable"
RSYNC_BASE_PARAMS="${RSYNC_BASE_PARAMS} --timeout=15"
RSYNC_BASE_PARAMS="${RSYNC_BASE_PARAMS} --modify-window=2"
RSYNC_BASE_PARAMS="${RSYNC_BASE_PARAMS} --verbose"
RSYNC_BASE_PARAMS="${RSYNC_BASE_PARAMS} --partial"
RSYNC_BASE_PARAMS="${RSYNC_BASE_PARAMS} --exclude '__pycache__'"
RSYNC_BASE_PARAMS="${RSYNC_BASE_PARAMS} --exclude 'node_modules'"

if [ -z $DOBACKUP ]; then
  RSYNC_BASE_PARAMS="${RSYNC_BASE_PARAMS} --dry-run"
fi

# Where is this script running from ?
SETUP_MEDIA_DIR=$(dirname "$(realpath "$0")")

# Create a temporary file for the setup log
if [ ! -z $DEBUG ]; then
  LOG_TEMPFILE=/dev/null
else
  LOG_TEMPFILE=$(mktemp)
fi

LAST_SYNC_LOG_FILE=/var/log/${APP_NAME}.log

# ############################################################################
#
# Internal use functions
#

# Show console log messages
function _log          {
  COLOR="$1"
  shift
  MSG="$@"
  TS="$(date --utc +%Y-%m-%dT%H:%M:%S)"
  echo -e "[${TS}] \e[${COLOR}m${MSG}\e[0m" | tee --append "${LOG_TEMPFILE}"
}

# Show console log messages
function log_msg        { _log "37" "$@" ; }
function log_highlight  { _log "37;1" "$@" ; }
function log_title      { _log "36" "$@" ; }
function log_success    { _log "32" "$@" ; }
function log_error      { _log "31" "$@" ; }
function log_warning    { _log "33" "$@" ; }
function log_command    { _log "34" "$@" ; }
function log_debug      { _log "35" "$@" ; }


# Execute a command
function RUNCMD {
  if [ ! -z $DEBUG ]; then
    log_debug "[DEBUG] $@"
    sleep 0.1
  else
    log_command "$@"
    bash -c "$@" 2>&1 | tee --append "${LOG_TEMPFILE}"
  fi
}


# Back up a single folder
function backup_folder {
  FOLDER="$1"
  log_title ------------------------------------------------ Backing up: ${FOLDER}
  PARAMS="${RSYNC_BASE_PARAMS} ${SOURCE_FOLDER}/${FOLDER}/ ${DEST_FOLDER}/${FOLDER}"
  RUNCMD "sudo rsync ${PARAMS}"
}

# ############################################################################
#
# Sync start
#

log_title -
log_title - [${APP_NAME}] Starting sync
log_title -
log_title - Running on [$(hostname)]
log_title - Started from ${SETUP_MEDIA_DIR}

if [ ! -z $DEBUG ]; then
  log_warning - [RUNNING IN DEBUG MODE]
fi

if [ -z $DOBACKUP ]; then
  log_warning - [RUNNING IN DRY MODE]
fi


for folder in $BACKUP_FOLDERS
do
  backup_folder $folder
done


log_success - ----------------------------------------------------------------------------
log_success -
log_success - [$APP_NAME] Sync finished successfully
log_success -
log_success - ----------------------------------------------------------------------------

if [ -z $DOBACKUP ]; then
  log_warning -
  log_warning - PLEASE NOTE THIS WAS A DRY RUN !!!!
  log_warning -
  log_warning - Check results and call use the following to do the actual backup:
  log_warning -  DOBACKUP=1 ${0}
  log_warning -
fi

RUNCMD "sudo cp ${LOG_TEMPFILE} ${LAST_SYNC_LOG_FILE}"
RUNCMD "sudo chown ${USER}:${USER} ${LAST_SYNC_LOG_FILE}"


if [ -z $DEBUG ]; then
  less --raw-control-chars --force ${LAST_SYNC_LOG_FILE}
fi
