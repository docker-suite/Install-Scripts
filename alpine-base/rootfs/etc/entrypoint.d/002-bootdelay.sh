#!/usr/bin/env bash

# Add libraries
source /usr/local/lib/bash-logger.sh
source /usr/local/lib/persist-env.sh

# define BOOT_DELAY
BOOT_DELAY=$(env_get "BOOT_DELAY")

# exit if no boot delay is defined
if [ -n "${BOOT_DELAY}" ]; then
    if isint "${BOOT_DELAY}"; then
        if [ "${BOOT_DELAY}" -gt "0" ]; then
            LOG info "Boot delayed of ${BOOT_DELAY} second(s)"
            sleep ${BOOT_DELAY}
        fi
    fi
fi

env_unset BOOT_DELAY
