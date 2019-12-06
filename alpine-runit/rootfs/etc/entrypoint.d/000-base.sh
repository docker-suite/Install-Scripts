#!/usr/bin/env bash

# Add libraries
source /usr/local/lib/persist-env.sh

# Change log format for bash-logger
env_set LOG_FORMAT '%MESSAGE'

# Modify bash-logger.sh log function behavior (don't exit on errors)
sed -i '/ERROR()/c\ERROR() { LOG_HANDLER_DEFAULT "$FUNCNAME" "$@"; }' /usr/local/lib/bash-logger.sh
sed -i '/CRITICAL()/c\CRITICAL() { LOG_HANDLER_DEFAULT "$FUNCNAME" "$@"; }' /usr/local/lib/bash-logger.sh
sed -i '/ALERT()/c\ALERT() { LOG_HANDLER_DEFAULT "$FUNCNAME" "$@"; }' /usr/local/lib/bash-logger.sh
sed -i '/EMERGENCY()/c\EMERGENCY() { LOG_HANDLER_DEFAULT "$FUNCNAME" "$@"; }' /usr/local/lib/bash-logger.sh

