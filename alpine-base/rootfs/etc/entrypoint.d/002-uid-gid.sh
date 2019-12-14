#!/usr/bin/env bash

# shellcheck disable=SC1091

## Add libraries
source /usr/local/lib/uid-gid.sh

## Envs
env_set DST_USER "$(env_get "DST_USER" "dsuite")"
env_set DST_UID "$(env_get "DST_UID" "1000")"
env_set DST_GROUP "$(env_get "DST_GROUP" "dsuite")"
env_set DST_GID "$(env_get "DST_GID" "1000")"
env_set DST_HOME "$(env_get "DST_HOME" "/home/${DST_USER}")"
NEW_USER=$(env_get "NEW_USER" "$DST_USER")
NEW_UID=$(env_get "NEW_UID" "$DST_UID")
NEW_GROUP=$(env_get "NEW_GROUP" "$DST_GROUP")
NEW_GID=$(env_get "NEW_GID" "$DST_GID")
NEW_HOME=$(env_get "NEW_HOME" "$DST_HOME")
USER=$(env_get "USER")

## Create default group
([[ -z "$(getent group "$DST_GID")" ]] && addgroup -S -g "${DST_GID}" "${DST_GROUP}") || true

## Create default user
([[ -z "$(getent passwd "$DST_UID")" ]] && adduser -S -D -u "${DST_UID}" -G "${DST_GROUP}" -h "$DST_HOME" -s /bin/bash "${DST_USER}") || true

## Rename user
if [[  ! "$NEW_USER" = "$DST_USER"  ]] && [[ -z "$(getent passwd "$NEW_USER")" ]]; then
    DEBUG "Rename user '${DST_USER}' to '${NEW_USER}'"
    LOG_RUN "usermod -l $NEW_USER $DST_USER"
fi

## Rename group
if [[  ! "$NEW_GROUP" = "$DST_GROUP"  ]] && [[ -z "$(getent group "$NEW_GROUP")" ]]; then
    DEBUG "Rename group '${DST_GROUP}' to ${NEW_GROUP}"
    LOG_RUN "groupmod -n $NEW_GROUP $DST_GROUP"
else
    if [[  ! "$NEW_GROUP" = "$DST_GROUP"  ]]; then
        DEBUG "Add user '$NEW_USER' to group '$NEW_GROUP'"
        LOG_RUN "adduser $NEW_USER $NEW_GROUP"
    fi
fi


## Rename home location
if [[  ! "$NEW_HOME" = "$DST_HOME"  ]] && [[ ! -d "$NEW_HOME" ]]; then
    DEBUG "Change home location '${NEW_USER}' to ${NEW_HOME}"
    LOG_RUN "usermod -d $NEW_HOME -m $NEW_USER"
fi

## Change UID
if [[  ! "$NEW_GID" = "$DST_GID"  ]]; then
    set_uid "${NEW_UID}" "${NEW_USER}" "${NEW_HOME}"
fi

## Change GID
if [[  ! "$NEW_UID" = "$DST_UID"  ]]; then
    set_gid "${NEW_GID}" "${NEW_GROUP}" "${NEW_HOME}"
fi

## Make our user like sudo
echo "${NEW_USER} ALL=(ALL) ALL" >> /etc/sudoers
echo "${NEW_USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

## Auto load /etc/profile for all known users
echo "source /etc/profile" > /root/.ashrc
echo "source /etc/profile" > /root/.bashrc
([[ -d "$NEW_HOME"  ]] && echo "source /etc/profile" > "$NEW_HOME/.ashrc") || true
([[ -d "$NEW_HOME"  ]] && echo "source /etc/profile" > "$NEW_HOME/.bashrc") || true
([[ -d "$(getent passwd "$USER" | cut -d: -f6)"  ]] && echo "source /etc/profile" > "$(getent passwd "$USER" | cut -d: -f6)/.ashrc") || true
([[ -d "$(getent passwd "$USER" | cut -d: -f6)"  ]] && echo "source /etc/profile" > "$(getent passwd "$USER" | cut -d: -f6)/.bashrc") || true
