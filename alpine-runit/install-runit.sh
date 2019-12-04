#!/usr/bin/env bash

# set -e : Exit the script if any statement returns a non-true return value.
set -e

# Update repository indexes
apk update

# curl must be installed: https://curl.haxx.se/
apk add --no-cache curl

# Download and run install-base script first and run it
if [ ! -f /tmp/install-base.sh ]; then
    curl -s -o /tmp/install-base.sh https://raw.githubusercontent.com/docker-suite/Install-Scripts/master/alpine-base/install-base.sh
fi
if [ -f /tmp/install-base.sh ]; then
    sh /tmp/install-base.sh
fi

# Download alpine-runit files if needded
if [ -z "$1" ]; then
    if [ -n "$GH_TOKEN" ]; then
        gh-downloader -T=$GH_TOKEN -u=docker-suite -r=Install-Scripts -p=alpine-runit/rootfs -o=/
    else
        gh-downloader -u=docker-suite -r=Install-Scripts -p=alpine-runit/rootfs -o=/
    fi
fi

# Make bin and sbin files accessible and executable
[ $(ls /usr/local/bin | wc -l) -gt 0 ] && chmod 0755 /usr/local/bin/*
[ $(ls /usr/local/sbin | wc -l) -gt 0 ] && chmod 0755 /usr/local/sbin/*

# Make entrypoint accessible and executable
chmod 0755 /etc/entrypoint.d/*.sh
chmod 0755 -R /etc/runit/*
chmod 0755 /entrypoint.sh

# Add packages
apk-install --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
    `# runit: http://smarden.org/runit/` \
    runit \
    && rm -f /sbin/runit \
    && rm -f /sbin/runit-init
