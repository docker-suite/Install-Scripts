#!/usr/bin/env bash
# shellcheck disable=SC1091

## Make entrypoints scripts accessible and executable
[ -d /etc/entrypoint.d ] && find /etc/entrypoint.d -name '*.sh' -type f -exec chmod 0755 {} \;

## Make startup scripts accessible and executable
[ -d /startup.d ]       && find /startup.d -name '*.sh' -type f -exec chmod 0755 {} \;
[ -d /startup.1.d ]     && find /startup.1.d -name '*.sh' -type f -exec chmod 0755 {} \;
[ -d /startup.2.d ]     && find /startup.2.d -name '*.sh' -type f -exec chmod 0755 {} \;

## Make bin and sbin files accessible and executable
find /usr/local/bin -type f -exec chmod 0755 {} \;
find /usr/local/sbin -type f -exec chmod 0755 {} \;

## logger
source /usr/local/lib/bash-logger.sh

## Persist env variables
source /usr/local/lib/persist-env.sh
