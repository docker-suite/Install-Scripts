#!/bin/sh

# set -e : Exit the script if any statement returns a non-true return value.
set -e

# exit if no boot delay is defined
[ -n "${BOOT_DELAY}" ] && ( echo "Boot delayed of ${BOOT_DELAY}"; sleep ${BOOT_DELAY} ) && unset BOOT_DELAY
