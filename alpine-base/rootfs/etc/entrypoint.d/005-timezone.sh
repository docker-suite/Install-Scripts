#!/usr/bin/env bash

## Check if TIMEZONE or TZ exist
TIMEZONE=$(env_get "TIMEZONE")
TZ=$(env_get "TZ")

## Set the time zone if neccessary
([ -n "${TIMEZONE}" ] && set-timezone "${TIMEZONE}") || true
([ -n "${TZ}" ] && set-timezone "${TZ}") || true
