#!/usr/bin/env bash

# shellcheck disable=SC1091

## Add libraries
source /usr/local/lib/uid-gid.sh

## Envs
env_set DST_USER "$(env_get "DST_USER" "dsuite")"
env_set DST_GROUP "$(env_get "DST_GROUP" "dsuite")"
env_set DST_UID "$(env_get "DST_UID" "1000")"
env_set DST_GID "$(env_get "DST_GID" "1000")"
NEW_USER=$(env_get "NEW_USER" "$DST_USER")
NEW_GROUP=$(env_get "NEW_GROUP" "$DST_GROUP")
NEW_UID=$(env_get "NEW_UID")
NEW_GID=$(env_get "NEW_GID")
USER=$(env_get "USER")

## Default User/Group
([ -z "$(getent group "$DST_GID")" ] && addgroup -S -g "${DST_GID}" "${DST_GROUP}") || true
([ -z "$(getent passwd "$DST_UID")" ] && adduser -S -u "${DST_UID}" -G "${DST_GROUP}" -s /bin/sh "${DST_USER}") || true

## Modify User/Group
## You cannot change your current user
([ -n "${NEW_UID}" ] && set_uid "${NEW_UID}" "${NEW_USER}" "/home/${DST_USER}") || true
([ -n "${NEW_GID}" ] && set_gid "${NEW_GID}" "${NEW_GROUP}" "/home/${DST_USER}") || true

## Auto load /etc/profile for all known users
echo "source /etc/profile" > /root/.ashrc
echo "source /etc/profile" > /root/.bashrc
echo "source /etc/profile" > "/home/${DST_USER}/.ashrc"
echo "source /etc/profile" > "/home/${DST_USER}/.bashrc"
if [ ! "$USER" = "" ] && [ -d "/home/${USER}" ]; then
    echo "source /etc/profile" > "/home/${USER}/.ashrc"
    echo "source /etc/profile" > "/home/${USER}/.bashrc"
fi

