#!/bin/sh
# shellcheck disable=SC2174

# set -e : Exit the script if any statement returns a non-true return value.
set -e

# Update repository indexes and add packages
apk update && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
    `# bash: https://tiswww.case.edu/php/chet/bash/bashtop.html/` \
    bash \
    `# coreutils: https://www.gnu.org/software/coreutils/` \
    coreutils \
    `# curl: https://curl.haxx.se/` \
    curl \
    `# grep: http://www.gnu.org/software/grep/` \
    grep \
    `# jq: https://stedolan.github.io/jq/` \
    jq \
    `# https://github.com/logrotate/logrotate` \
    logrotate\
    `# procps: https://gitlab.com/procps-ng/procps/` \
    procps \
    `# sed: http://www.gnu.org/software/sed/` \
    sed \
    `# shadow: Add usermod and groupmod` \
    shadow \
    `# su-exec: https://github.com/ncopa/su-exec` \
    su-exec \
    `# tini: https://github.com/krallin/tini` \
    `# Why tini: https://github.com/krallin/tini/issues/8` \
    tini

# Make sure folders exist
mkdir -p /startup.d
mkdir -p /startup.1.d
mkdir -p /startup.2.d
mkdir -p /etc/entrypoint.d
mkdir -p /usr/local/bin
mkdir -p /usr/local/lib
mkdir -p /usr/local/sbin

# Add tools
curl -s -o /usr/local/sbin/gh-downloader https://raw.githubusercontent.com/bash-suite/gh-downloader/master/gh-downloader.sh
curl -s -o /usr/local/sbin/templater https://raw.githubusercontent.com/bash-suite/templater/master/templater.sh
curl -s -o /usr/local/sbin/wait-host https://raw.githubusercontent.com/bash-suite/wait-host/master/wait-host.sh
curl -s -o /usr/local/sbin/mvlink https://raw.githubusercontent.com/bash-suite/mvlink/master/mvlink.sh
curl -s -o /usr/local/lib/bash-logger.sh https://raw.githubusercontent.com/bash-suite/bash-logger/master/bash-logger.sh
curl -s -o /usr/local/lib/persist-env.sh https://raw.githubusercontent.com/bash-suite/persist-env/master/persist-env.sh

# Download alpine-base files if needded
if [ -z "$1" ]; then
    if [ -n "$GH_TOKEN" ]; then
        sh /usr/local/sbin/gh-downloader -T="$GH_TOKEN" -u=docker-suite -r=Install-Scripts -p=alpine-base/rootfs -o=/
    else
        sh /usr/local/sbin/gh-downloader -u=docker-suite -r=Install-Scripts -p=alpine-base/rootfs -o=/
    fi
fi

# Adjust folders permissions
chmod -R 0660 /etc/entrypoint.d
chmod -R 0660 /startup.d
chmod -R 0770 /startup.1.d
chmod -R 0770 /startup.2.d

# Make sure binaries are accessible and executable
[ "$(find /usr/local/bin -type f  | wc -l)" -gt "0" ] && chmod 0755 /usr/local/bin/*
[ "$(find /usr/local/sbin -type f | wc -l)" -gt "0" ] && chmod 0755 /usr/local/sbin/*

# Adjust files permissions
chmod 0600 /etc/crontabs/root
chmod 0777 /etc/periodic/daily/logrotate

# Make entrypoint script accessible and executable
chmod 0755 /entrypoint.sh
