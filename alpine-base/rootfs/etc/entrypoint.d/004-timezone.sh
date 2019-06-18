#!/usr/bin/env bash

# Add libraries
source /usr/local/lib/persist-env.sh

TIMEZONE=$(env_get "TIMEZONE")
TZ=$(env_get "TZ")

[ -n "${TIMEZONE}" ] && set-timezone "${TIMEZONE}" || true
[ -n "${TZ}" ] && set-timezone "${TZ}" || true
