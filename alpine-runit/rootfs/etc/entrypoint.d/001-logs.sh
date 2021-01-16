#!/usr/bin/env bash
# shellcheck disable=SC2016

## Set default log level to NOTICE
## Do not output DEBUG and INFO level
## Except if DEBUG_LEVEL is defined
env_set "DEBUG_LEVEL" "$(env_get "DEBUG_LEVEL" "NOTICE")"
env_set "LOG_LEVEL" "$(LOG_LEVEL_VALUE "${DEBUG_LEVEL}")"

## Don't log to file
env_set "LOG_LOGFILE_ENABLE" "0"

## Define the log format which will be used in all dsuite images
env_set "LOG_FORMAT" '%MESSAGE'

## Display the following message if DEBUG_LEVEL is at leadt defined at INFO
INFO "Log level set to $(LOG_LEVEL_NAME "${LOG_LEVEL}")"

# Modify bash-logger.sh log function behavior (don't exit on errors)
sed -i '/ERROR()/c\ERROR() { LOG_HANDLER_DEFAULT "$FUNCNAME" "$@"; }' /usr/local/lib/bash-logger.sh
sed -i '/CRITICAL()/c\CRITICAL() { LOG_HANDLER_DEFAULT "$FUNCNAME" "$@"; }' /usr/local/lib/bash-logger.sh
sed -i '/ALERT()/c\ALERT() { LOG_HANDLER_DEFAULT "$FUNCNAME" "$@"; }' /usr/local/lib/bash-logger.sh
sed -i '/EMERGENCY()/c\EMERGENCY() { LOG_HANDLER_DEFAULT "$FUNCNAME" "$@"; }' /usr/local/lib/bash-logger.sh

