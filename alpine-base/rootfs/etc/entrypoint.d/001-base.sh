#!/usr/bin/env bash

# Add libraries
source /usr/local/lib/bash-logger.sh
source /usr/local/lib/persist-env.sh
source /usr/local/lib/uid-gid.sh

# Debug level
env_set "DEBUG_LEVEL" $(env_get "DEBUG_LEVEL" "NOTICE")
env_set "LOG_LEVEL" $(LOG_LEVEL_VALUE ${DEBUG_LEVEL})
LOG info "Debug level set to $(LOG_LEVEL_NAME ${LOG_LEVEL})"

# Envs
env_set DST_USER "dsuite"
env_set DST_GROUP "dsuite"
env_set DST_UID "1000"
env_set DST_GID "1000"
NEW_UID=$(env_get "NEW_UID")
NEW_GID=$(env_get "NEW_GID")

## Reload environnement variables
env_reload

## Default User/Group
[ -z "$(getent group "$DST_GID")" ] && addgroup -S -g "${DST_GID}" "${DST_GROUP}"
[ -z "$(getent passwd "$DST_UID")" ] && adduser -S -u "${DST_UID}" -G "${DST_GROUP}" -s /bin/sh "${DST_USER}"

# Modify User/Group
[ -n "${NEW_UID}" ] && set_uid "${NEW_UID}" "${DST_USER}" "/home/${DST_USER}"
[ -n "${NEW_GID}" ] && set_gid "${NEW_GID}" "${DST_GROUP}" "/home/${DST_USER}"
