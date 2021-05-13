#!/usr/bin/env bash

# Make sure folders exist
mkdir -p /etc/service.d
mkdir -p /etc/runit/init.d
mkdir -p /etc/runit/finish.d

# Make sure init and finish scripts are runnables
find /etc/runit/init.d -name '*.sh' -type f -exec chmod 0755 {} \;
find /etc/runit/finish.d -name '*.sh' -type f -exec chmod 0755 {} \;

# Give acces to the current user
if [[ -n "$USER" ]]; then
    chown -R "${USER}" /etc/service.d
fi
