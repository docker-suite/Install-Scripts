#!/usr/bin/env bash

# set -e : Exit the script if any statement returns a non-true return value.
set -e
# Update repository indexes and add packages
apk update && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
        `# curl: https://curl.haxx.se/` \
        curl \
        `# runit: http://smarden.org/runit/` \
        runit \
    && rm -f /sbin/runit \
    && rm -f /sbin/runit-init

# Download and run install-base script first and run it
if [ ! -f /tmp/install-base.sh ]; then
    curl -s -o /tmp/install-base.sh https://raw.githubusercontent.com/docker-suite/Install-Scripts/master/alpine-base/install-base.sh
fi
if [ -f /tmp/install-base.sh ]; then
    sh /tmp/install-base.sh "$@"
fi

# Download alpine-runit files if needded
if [ -z "$1" ]; then
    if [ -n "$GH_TOKEN" ]; then
        gh-downloader -T="$GH_TOKEN" -u=docker-suite -r=Install-Scripts -p=alpine-runit/rootfs -o=/
    else
        gh-downloader -u=docker-suite -r=Install-Scripts -p=alpine-runit/rootfs -o=/
    fi
fi

# Make entrypoint script accessible and executable
chmod 0755 /entrypoint.sh
