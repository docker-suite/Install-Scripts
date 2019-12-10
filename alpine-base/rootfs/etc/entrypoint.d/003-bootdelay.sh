#!/usr/bin/env bash

## Check if BOOT_DELAY is defined
BOOT_DELAY=$(env_get "BOOT_DELAY")

## exit if no boot delay is defined
if [ -n "${BOOT_DELAY}" ]; then
    if isint "${BOOT_DELAY}"; then
        if [ "${BOOT_DELAY}" -gt "0" ]; then
            INFO  "Boot delayed of ${BOOT_DELAY} second(s)"
            sleep "${BOOT_DELAY}"
        fi
    fi
fi

env_unset BOOT_DELAY
