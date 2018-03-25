#!/bin/sh

# set -e : Exit the script if any statement returns a non-true return value.
set -e

[ -n "${TIMEZONE}" ] && set-timezone ${TIMEZONE}
