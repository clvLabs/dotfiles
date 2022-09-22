#!/bin/bash

# ############################################################################
#
# utils.sh
#
# Internal use functions
#

# Show console log messages
function _log {
  COLOR="$1"
  shift
  MSG="$@"
  TS="$(date --utc +%Y-%m-%dT%H:%M:%S)"
  echo -e "[${TS}] \e[${COLOR}m${MSG}\e[0m" | tee --append "$LOG_TEMPFILE"
}

# Show console log messages
function log_msg        { _log "37" "$@" ; }
function log_highlight  { _log "37;1" "$@" ; }
function log_title      { _log "36" "$@" ; }
function log_success    { _log "32" "$@" ; }
function log_error      { _log "31" "$@" ; }
function log_warning    { _log "33" "$@" ; }
function log_debug      { _log "35" "$@" ; }

# Execute a command
function RUNCMD {
  if [ ! -z $DEBUG ]; then
    log_debug "[DEBUG] $@"
    sleep 0.1
  else
    log_warning "$@"
    bash -c "$@" 2>&1 | tee --append "$LOG_TEMPFILE"
  fi
}

# Abort program setup
function abort_setup {
  [[ -z $DEBUG ]] && rm "$LOG_TEMPFILE"
  log_error "Setup CANCELLED"
  log_warning "[FINISHED]"
	exit 1
}


# ############################################################################
#
# Script initialization
#

PROJECT_BASE_DIR=$(readlink -f $THIS_SCRIPT_DIR/../..)
EXPECTED_PROJECT_BASE_DIR=$(readlink -f "$HOME/.config/dotfiles")

UTILITY_SCRIPTS_DIR=$PROJECT_BASE_DIR/scripts
CONFIG_DIR=$PROJECT_BASE_DIR/config

SETUP_DIR=$PROJECT_BASE_DIR/setup
SETUP_SCRIPTS_DIR=$SETUP_DIR/scripts
SETUP_RESOURCES_DIR=$SETUP_DIR/resources
SETUP_LOGS_DIR=$SETUP_DIR/log

# Make sure log folder exists
mkdir -p $SETUP_LOGS_DIR

# Check setup base dir
if [[ "$PROJECT_BASE_DIR" != "$EXPECTED_PROJECT_BASE_DIR" ]]; then
  log_error "dotfiles seems to be at a strange location: $PROJECT_BASE_DIR"
  log_error "It is expected to be installed at: $EXPECTED_PROJECT_BASE_DIR"
  abort_setup
fi

# Create a temporary file for the setup log
if [ ! -z $DEBUG ]; then
  LOG_TEMPFILE=/dev/null
else
  LOG_TEMPFILE=$(mktemp)
fi

# Show title
log_title - ----------------------------------------------------------------------------
log_title -
log_title - [$APP_NAME] Starting
log_title -
log_title - Running on [$(hostname)]
log_title -

if [ ! -z $DEBUG ]; then
log_title - [RUNNING IN DEBUG MODE]
log_title -
fi
