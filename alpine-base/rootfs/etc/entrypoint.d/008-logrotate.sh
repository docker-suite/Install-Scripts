#!/usr/bin/env bash

# Create message file if necessary
mkdir -p /var/log
touch /var/log/messages

# Make sure logrotate will execute as a cron task
chmod 755 /etc/periodic/daily/logrotate

# Change permission for files in /etc/logrotate.d/*
[ -d /etc/logrotate.d ] && find /etc/logrotate.d ! -name '*.*' -type f -exec chmod 0644 {} \;

