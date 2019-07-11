#!/usr/bin/env bash

# Add libraries
source /usr/local/lib/persist-env.sh

# Environment variables
env_set "MAIN_RESTART" $(env_get "MAIN_RESTART" "0")
