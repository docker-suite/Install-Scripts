#!/usr/bin/env bash
# shellcheck disable=SC1091

## Make entrypoint.d scripts accessible and executable
[ -d /etc/entrypoint.d ] && [ "$(find /etc/entrypoint.d -name '*.sh' -type f | wc -l)" -gt "0" ] && chmod 0755 /etc/entrypoint.d/*.sh

## Make startup scripts accessible and executable
[ -d /startup.d ]   && [ "$(find /startup.d -name '*.sh' -type f | wc -l)" -gt "0" ]   && chmod 0755 /startup.d/*.sh
[ -d /startup.1.d ] && [ "$(find /startup.1.d -name '*.sh' -type f | wc -l)" -gt "0" ] && chmod 0755 /startup.1.d/*.sh
[ -d /startup.2.d ] && [ "$(find /startup.2.d -name '*.sh' -type f | wc -l)" -gt "0" ] && chmod 0755 /startup.2.d/*.sh

## Make bin and sbin files accessible and executable
[ "$(find /usr/local/bin -type f  | wc -l)" -gt "0" ] && chmod 0755 /usr/local/bin/*
[ "$(find /usr/local/sbin -type f | wc -l)" -gt "0" ] && chmod 0755 /usr/local/sbin/*

## logger
source /usr/local/lib/bash-logger.sh

## Persist env variables
source /usr/local/lib/persist-env.sh
