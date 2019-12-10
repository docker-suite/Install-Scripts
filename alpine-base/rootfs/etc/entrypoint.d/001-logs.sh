#!/usr/bin/env bash

## Set default log level to INFO
## Do not output DEBUG and INFO level
## Except if DEBUG_LEVEL is defined
env_set "DEBUG_LEVEL" "$(env_get "DEBUG_LEVEL" "NOTICE")"
env_set "LOG_LEVEL" "$(LOG_LEVEL_VALUE "${DEBUG_LEVEL}")"

## Define the log format which will be used in all dsuite images
env_set "LOG_FORMAT" '%DATE %PID [%LEVEL] %MESSAGE'

## Display the following message if DEBUG_LEVEL is at leadt defined at INFO
INFO "Log level set to $(LOG_LEVEL_NAME "${LOG_LEVEL}")"
